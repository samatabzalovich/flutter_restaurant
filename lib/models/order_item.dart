// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_restaurant/models/item.dart';

class OrderItem {
  final Item item;
  int amount;
   double price;
  OrderItem({
    required this.item,
    required this.amount,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item': item.toMap(),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      item: Item.fromMap({'item_id': map['item_id'], 'name': map['name'], 'image': map['image'], 'item_id': map['item_id']}),
      amount: map['amount'] as int,
      price: map['price'] as double,
    );
  }


}
