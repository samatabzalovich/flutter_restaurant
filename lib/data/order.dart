import 'package:flutter_restaurant/data/database_helper.dart';
import 'package:flutter_restaurant/models/order.dart';
import 'package:flutter_restaurant/models/order_item.dart';

import '../models/category.dart';

class OrderDB {
  final DBProvider _dbHelper;

  OrderDB(this._dbHelper);
  Future<int> insertOrder(Order order) async {
    final db = await _dbHelper.database;
    final int id = await db.rawInsert(
      """INSERT INTO orders(table_name, total_price) VALUES ('${order.tableName}', ${order.price})""",
    );
    return id;
  }

  Future<void> insertOrderItems(int orderId, List<OrderItem> items) async {
    final db = await _dbHelper.database;
    for (var element in items) {
      await db.rawInsert('INSERT INTO order_items(order_id,item_id, amount, price) VALUES($orderId, ${element.item.id}, ${element.amount}, ${element.price})');
    }
  }

  Future<List<Order>> getOrder() async {
    final db = await _dbHelper.database;
    final orders =
        await db.rawQuery('Select * from orders order by created_at');
    List<Order> order = [];
    for (var element in orders) {
      order.add(Order.fromMap(element));
    }
    return order;
  }

  Future<List<OrderItem>> getOrderItems(Order order) async {
    final db = await _dbHelper.database;
    final orderItems = await db
        .rawQuery('''
  SELECT o.amount, o.price, o.order_id, i.item_id, i.name, i.image 
  FROM order_items o
  JOIN items i ON i.item_id = o.item_id
  WHERE o.order_id = ${order.id}
''');
    List<OrderItem> items = [];
    for (var element in orderItems) {
      items.add(OrderItem.fromMap(element));
    }
    return items;
  }
}
