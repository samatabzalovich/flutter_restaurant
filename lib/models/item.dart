class Item {
  final int id;
  final String name;
  final double? price;
  final String image;
  final int? amount;
  Item({
    required this.id,
    required this.name,
     this.price,
    required this.image,
     this.amount
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_id': id,
      'name': name,
      'price': price,
      'image': image,
      'amount': amount
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['item_id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] ?? 0,
      amount: map['amount'] ?? 999,
    );
  }
}
