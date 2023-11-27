// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_restaurant/models/order_item.dart';

class Order {
  final int id;
  final String tableName;
  final double price;
  final DateTime createdAt;
  List<OrderItem>? orderItems;
  Order({
    required this.id,
    required this.tableName,
    required this.price,
    required this.createdAt,
    this.orderItems,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'table_name': tableName, 'total_price': price};
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      tableName: map['table_name'] as String,
      price: map['total_price'] as double,
      createdAt: DateTime.parse(map['created_at'])
    );
  }
}
