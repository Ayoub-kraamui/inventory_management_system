import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:inventory_management_system/model/purchases_model.dart';
import 'package:inventory_management_system/model/sales_modle.dart';
import 'package:inventory_management_system/model/store_modle.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _dbName = "store.db";
  static const _dbVersion = 1;
  static const _tableName = "purchases";
  static const _tableName2 = "sales";
  static const _tableName3 = "stores";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY,
        productName TEXT NOT NULL,
        quantity TEXT NOT NULL,
        unity TEXT NOT NULL,
        purchasePrice TEXT NOT NULL,
        salesPrice TEXT NOT NULL,
        value TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL
      )
      ''');

    await db.execute(
        '''
      CREATE TABLE $_tableName2(
        id INTEGER PRIMARY KEY,
        productName TEXT NOT NULL,
        quantity TEXT NOT NULL,
        unity TEXT NOT NULL,
        salesPrice TEXT NOT NULL,
        value TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL
      )
      ''');

    await db.execute(
        '''
      CREATE TABLE $_tableName3(
        id INTEGER PRIMARY KEY,
        productName TEXT NOT NULL,
        quantity TEXT NOT NULL,
        unity TEXT NOT NULL,
        purchasePrice TEXT NOT NULL,
        salesPrice TEXT NOT NULL,
        value TEXT NOT NULL

      )
      ''');
  }

//========================== purchases ===============================
  // Add purchases
  Future<int> addPurchases(Purchases purchases, Stores stores) async {
    Database db = await instance.database;
    return await db.transaction((txn) async {
      // إضافة المشتريات
      int purchaseId = await txn.insert(_tableName, purchases.toMap());
      final existingStore = await txn.query(
        _tableName3,
        where: 'productName = ?',
        whereArgs: [stores.productName], // تأكد من أن لديك حقل productId
      );
      if (existingStore.isNotEmpty) {
        // تحديث الكمية للصنف الموجود
        int newQuantity =
            int.tryParse(existingStore.first['quantity'].toString())! +
                int.parse(stores.quantity.toString());
        double existingValue =
            double.tryParse(existingStore.first['value'].toString()) ?? 0;

        // حساب القيمة الجديدة
        double newValue = existingValue +
            (int.parse(stores.quantity!) * double.parse(stores.salesPrice!));

        await txn.update(
          _tableName3,
          {
            'quantity': newQuantity,
            'value': newValue,
          },
          where: 'productName = ?',
          whereArgs: [stores.productName],
        );
      } else {
        // إضافة إلى المخازن إذا لم يكن موجودًا
        double initialValue =
            int.parse(stores.quantity!) * double.parse(stores.salesPrice!);
        stores.value = initialValue.toString();
        await txn.insert(_tableName3, stores.toMap());
      }

      return purchaseId; // أو يمكنك إرجاع storeId إذا كان ذلك مناسبًا
    });
  }

  // Delete purchases
  Future<int> deletePurchases(Purchases purchases, Stores stores) async {
    Database db = await instance.database;
    return await db.transaction((txn) async {
      int purchaseId = await txn.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [purchases.id],
      );
      final existingStore = await txn.query(
        _tableName3,
        where: 'productName = ?',
        whereArgs: [stores.productName], // تأكد من أن لديك حقل productId
      );
      if (existingStore.isNotEmpty) {
        // تحديث الكمية للصنف الموجود
        int existingQuantity =
            int.tryParse(existingStore.first['quantity'].toString()) ?? 0;
        double existingValue =
            double.tryParse(existingStore.first['value'].toString()) ?? 0;
        double existingsalesPrice =
            double.tryParse(existingStore.first['salesPrice'].toString()) ?? 0;

        // حساب الكمية الجديدة
        int quantityToDelete = int.tryParse(stores.quantity ?? '0') ?? 0;
        int newQuantity = existingQuantity - quantityToDelete;

        // حساب القيمة الجديدة
        double valueToDelete = quantityToDelete * existingsalesPrice;
        double newValue = existingValue - valueToDelete;

        // تحديث الكمية والقيمة
        await txn.update(
          _tableName3,
          {
            'quantity': newQuantity,
            'value': newValue,
          },
          where: 'productName = ?',
          whereArgs: [stores.productName],
        );
      }
      return purchaseId;
    });
  }

  // Delete All purchases
  Future<int> deleteAllPurchases() async {
    Database db = await instance.database;
    return await db.delete(_tableName);
  }

  // Update purchases
  Future<int> updatePurchases(Purchases purchases) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      purchases.toMap(),
      where: "id = ?",
      whereArgs: [purchases.id],
    );
  }

  Future<List<Purchases>> getpurchasesList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(
      maps.length,
      (index) {
        return Purchases(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          purchasePrice: maps[index]["purchasePrice"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

  //getDailyPurchases
  Future<List<Purchases>> getDailyPurchases() async {
    Database db = await instance.database;
    final today = DateFormat("MMM dd, yyyy").format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'dateTimeCreated = ?',
      whereArgs: [today],
    );

    return List.generate(
      maps.length,
      (index) {
        return Purchases(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          purchasePrice: maps[index]["purchasePrice"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

  //getWeeklyPurchases
  Future<List<Purchases>> getWeeklyPurchases() async {
    Database db = await instance.database;
    final today = DateTime.now();
    final startOfWeek =
        today.subtract(Duration(days: today.weekday - 1)); // بداية الأسبوع
    final endOfWeek = startOfWeek.add(Duration(days: 6)); // نهاية الأسبوع

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: "dateTimeCreated BETWEEN ? AND ?",
      whereArgs: [
        DateFormat("MMM dd, yyyy").format(startOfWeek),
        DateFormat("MMM dd, yyyy").format(endOfWeek),
      ],
    );

    return List.generate(
      maps.length,
      (index) {
        return Purchases(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          purchasePrice: maps[index]["purchasePrice"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

//getMonthlyPurchases
  Future<List<Purchases>> getMonthlyPurchases() async {
    Database db = await instance.database;
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1); // بداية الشهر
    final endOfMonth = DateTime(today.year, today.month + 1, 0); // نهاية الشهر

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: "dateTimeCreated BETWEEN ? AND ?",
      whereArgs: [
        DateFormat("MMM dd, yyyy").format(startOfMonth),
        DateFormat("MMM dd, yyyy").format(endOfMonth),
      ],
    );
    return List.generate(
      maps.length,
      (index) {
        return Purchases(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          purchasePrice: maps[index]["purchasePrice"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

  //=========================== Sales =================================

  // Add Sales
  Future<int> addSales(Sales sales, Stores stores) async {
    Database db = await instance.database;
    return await db.transaction((txn) async {
      int salesId = await txn.insert(_tableName2, sales.toMap());

      final existingStore = await txn.query(
        _tableName3,
        where: 'productName = ?',
        whereArgs: [stores.productName], // تأكد من أن لديك حقل productName
      );

      if (existingStore.isNotEmpty) {
        // تحديث الكمية للصنف الموجود
        int existingQuantity =
            int.tryParse(existingStore.first['quantity'].toString()) ?? 0;
        int quantitySold = int.tryParse(stores.quantity.toString()) ?? 0;

        int newQuantity = existingQuantity - quantitySold; // خصم الكمية المباعة
        double existingValue =
            double.tryParse(existingStore.first['value'].toString()) ?? 0;

        // حساب القيمة الجديدة
        double salesPriceValue =
            double.tryParse(sales.salesPrice ?? '0') ?? 0.0;
        double newValue = existingValue - (quantitySold * salesPriceValue);

        if (newQuantity < 0) {
          // إذا كانت الكمية الجديدة أقل من صفر، يمكنك اتخاذ إجراء (مثل إرجاع خطأ، أو إلغاء العملية)
          throw "الكمية المتاحة $existingQuantity فقط ";
        } else if (newQuantity >= 0) {
          await txn.update(
            _tableName3,
            {
              'quantity': newQuantity,
              'value': newValue,
            },
            where: 'productName = ?',
            whereArgs: [stores.productName],
          );
        }
      } else {
        // إذا لم يكن موجودًا، يمكنك إرجاع خطأ أو إضافة عملية جديدة حسب الحاجة
        throw "الصنف غير موجود في المخزن";
      }

      return salesId; // إرجاع معرف عملية البيع
    });
  }

  // Delete Sales
  Future<int> deleteSales(Sales sales, Stores stores) async {
    Database db = await instance.database;
    return await db.transaction((txn) async {
      // حذف عملية البيع
      int salesId = await txn.delete(
        _tableName2,
        where: "id = ?",
        whereArgs: [sales.id],
      );

      final existingStore = await txn.query(
        _tableName3,
        where: 'productName = ?',
        whereArgs: [stores.productName], // تأكد من أن لديك حقل productName
      );

      if (existingStore.isNotEmpty) {
        // تحديث الكمية للصنف الموجود
        int existingQuantity =
            int.tryParse(existingStore.first['quantity'].toString()) ?? 0;
        double existingValue =
            double.tryParse(existingStore.first['value'].toString()) ?? 0;
        double existingSalesPrice =
            double.tryParse(existingStore.first['salesPrice'].toString()) ?? 0;

        // حساب الكمية الجديدة
        int quantityToDelete = int.tryParse(stores.quantity ?? '0') ?? 0;
        int newQuantity =
            existingQuantity + quantityToDelete; // إضافة الكمية بدلاً من الطرح

        // حساب القيمة الجديدة
        double valueToDelete = quantityToDelete * existingSalesPrice;
        double newValue =
            existingValue + valueToDelete; // إضافة القيمة بدلاً من الطرح

        if (newQuantity <= 0) {
          // إذا كانت الكمية الجديدة صفر أو أقل، احذف السجل
          await txn.delete(
            _tableName3,
            where: "productName = ?",
            whereArgs: [stores.productName],
          );
        } else {
          // تحديث الكمية والقيمة
          await txn.update(
            _tableName3,
            {
              'quantity': newQuantity,
              'value': newValue,
            },
            where: 'productName = ?',
            whereArgs: [stores.productName],
          );
        }
      }

      return salesId; // إرجاع معرف عملية البيع المحذوفة
    });
  }

  // Delete All Sales
  Future<int> deleteAllSales() async {
    Database db = await instance.database;
    return await db.delete(_tableName2);
  }

  // Update Sales
  Future<int> updateSales(Sales sales) async {
    Database db = await instance.database;
    return await db.update(
      _tableName2,
      sales.toMap(),
      where: "id = ?",
      whereArgs: [sales.id],
    );
  }

  Future<List<Sales>> getSalesList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName2);

    return List.generate(
      maps.length,
      (index) {
        return Sales(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

  //getDailySales
  Future<List<Sales>> getDailySales() async {
    Database db = await instance.database;
    final today = DateFormat("MMM dd, yyyy").format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName2,
      where: 'dateTimeCreated = ?',
      whereArgs: [today],
    );

    return List.generate(
      maps.length,
      (index) {
        return Sales(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

  //getWeeklySales
  Future<List<Sales>> getWeeklySales() async {
    Database db = await instance.database;
    final today = DateTime.now();
    final startOfWeek =
        today.subtract(Duration(days: today.weekday - 1)); // بداية الأسبوع
    final endOfWeek = startOfWeek.add(Duration(days: 6)); // نهاية الأسبوع

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName2,
      where: "dateTimeCreated BETWEEN ? AND ?",
      whereArgs: [
        DateFormat("MMM dd, yyyy").format(startOfWeek),
        DateFormat("MMM dd, yyyy").format(endOfWeek),
      ],
    );

    return List.generate(
      maps.length,
      (index) {
        return Sales(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

//getMonthlySales
  Future<List<Sales>> getMonthlySales() async {
    Database db = await instance.database;
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1); // بداية الشهر
    final endOfMonth = DateTime(today.year, today.month + 1, 0); // نهاية الشهر

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName2,
      where: "dateTimeCreated BETWEEN ? AND ?",
      whereArgs: [
        DateFormat("MMM dd, yyyy").format(startOfMonth),
        DateFormat("MMM dd, yyyy").format(endOfMonth),
      ],
    );
    return List.generate(
      maps.length,
      (index) {
        return Sales(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }

  //========================== Stores ===============================
  // Add Stores
  Future<int> addStores(Stores stores) async {
    Database db = await instance.database;
    return await db.insert(_tableName3, stores.toMap());
  }

  // Delete Stores
  Future<int> deleteStores(Stores stores) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName3,
      where: "id = ?",
      whereArgs: [stores.id],
    );
  }

  // Delete All Stores
  Future<int> deleteAllStores() async {
    Database db = await instance.database;
    return await db.delete(_tableName3);
  }

  // Update Stores
  Future<int> updateStores(Stores stores) async {
    Database db = await instance.database;
    return await db.update(
      _tableName3,
      stores.toMap(),
      where: "id = ?",
      whereArgs: [stores.id],
    );
  }

  Future<List<Stores>> getStoresList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName3);

    return List.generate(
      maps.length,
      (index) {
        return Stores(
          id: maps[index]["id"],
          productName: maps[index]["productName"],
          quantity: maps[index]["quantity"],
          unity: maps[index]["unity"],
          purchasePrice: maps[index]["purchasePrice"],
          salesPrice: maps[index]["salesPrice"],
          value: maps[index]["value"],
        );
      },
    );
  }
}
