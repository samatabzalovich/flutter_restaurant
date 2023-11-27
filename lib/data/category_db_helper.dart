import 'package:flutter_restaurant/data/database_helper.dart';
import 'package:flutter_restaurant/models/category.dart';

class CategoryDBHelper {
  final DBProvider _dbHelper;

  CategoryDBHelper(this._dbHelper);
  Future<List<Category>> getCategories() async {
    final db = await _dbHelper.database;
    final categories =
        await db.rawQuery('Select * from category');
    List<Category> order = [];
    for (var element in categories) {
      order.add(Category.fromMap(element));
    }
    return order;
  }

}