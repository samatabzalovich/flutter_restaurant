import 'package:flutter_restaurant/data/database_helper.dart';
import 'package:flutter_restaurant/models/category.dart';
import 'package:flutter_restaurant/models/item.dart';

class ItemDBHelper {
  final DBProvider _dbHelper;

  ItemDBHelper(this._dbHelper);
  Future<List<Item>> getItems(int categoryId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> query =
        await db.rawQuery('Select * from items where category_id = $categoryId');
    List<Item> items = [];
    for (var element in query) {
      items.add(Item.fromMap(element));
    }
    return items;
  }

}