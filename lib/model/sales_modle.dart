class Sales {
  final int? id;
  final String? productName;
  final String? quantity;
  final String? unity;
  final String? salesPrice;
  final String? value;
  final String? dateTimeCreated;

  Sales(
      {this.id,
      this.productName,
      this.quantity,
      this.unity,
      this.salesPrice,
      this.value,
      this.dateTimeCreated});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productName": productName,
      "quantity": quantity,
      "unity": unity,
      "salesPrice": salesPrice,
      "value": value,
      "dateTimeCreated": dateTimeCreated,
    };
  }
}
