class Stores {
  final int? id;
  final String? productName;
  final String? quantity;
  final String? unity;
  final String? purchasePrice;
  final String? salesPrice;
  String? value;

  Stores({
    this.id,
    this.productName,
    this.quantity,
    this.unity,
    this.purchasePrice,
    this.salesPrice,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productName": productName,
      "quantity": quantity,
      "unity": unity,
      "purchasePrice": purchasePrice,
      "salesPrice": salesPrice,
      "value": value,
    };
  }
}
