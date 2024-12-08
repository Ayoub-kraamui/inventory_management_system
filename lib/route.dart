import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:inventory_management_system/approute.dart';
import 'package:inventory_management_system/homepage.dart';
import 'package:inventory_management_system/screen/login.dart';
import 'package:inventory_management_system/screen/purchases.dart';
import 'package:inventory_management_system/screen/sales.dart';
import 'package:inventory_management_system/screen/stores.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const Login()),
  GetPage(name: AppRoute.homepage, page: () => const HomePage()),
  GetPage(name: AppRoute.sales, page: () => const SalesScreen()),
  GetPage(name: AppRoute.purchases, page: () => const PurchasesScreen()),
  GetPage(name: AppRoute.stores, page: () => const StoresScreen()),
];
