import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sq;

class DBProvider {
  sq.Database? _database;
  Future<sq.Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "restaurant.db";
    final path = await sq.getDatabasesPath();
    return join(path, name);
  }

  Future<sq.Database> _initialize() async {
    final path = await fullPath;
    var database = sq.openDatabase(path, version: 1,
        onCreate: (sq.Database database, _) async {
      await database.execute('''
          CREATE TABLE IF NOT EXISTS category (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);
        ''');
      
        await database.execute('''
          CREATE TABLE IF NOT EXISTS orders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT NOT NULL,
  total_price REAL NOT NULL,
  created_at DATE DEFAULT (datetime('now','localtime'))
);
        ''');
      await database.execute('''
          CREATE TABLE IF NOT EXISTS order_items (
  order_id INTEGER NOT NULL,
  item_id INTEGER NOT NULL,
  amount INTEGER NOT NULL,
  price REAL NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders (id),
  FOREIGN KEY (item_id) REFERENCES items (item_id)
);

        ''');
        await database.execute('''
          CREATE TABLE IF NOT EXISTS items (
  item_id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  price REAL,
  image TEXT NOT NULL,
  amount INTEGER DEFAULT 999,
  category_id INTEGER NOT NULL,
  FOREIGN KEY (category_id) REFERENCES category (id)
);
        ''');
        await database.execute('''
          INSERT INTO category (
  name
) VALUES (
  'напитки'
);
        ''');
      await database.execute('''
          INSERT INTO category (
  name
) VALUES (
  '1 блюдо'
);
        ''');
      

      await database.execute('''
          INSERT INTO items (
  name,
  price,
  image,
  category_id
) VALUES (
  'cola',
  500.55,
  'https://elitalco.kz/upload/images/23751_719597_09.jpeg',
  1
);
        ''');
      await database.execute('''
          INSERT INTO items (
  name,
  price,
  image,
  category_id
) VALUES (
  'cola 0.5',
  222.55,
  'https://elitalco.kz/upload/images/23751_719597_09.jpeg',
  1
);
        ''');
        await database.execute('''
          INSERT INTO items (
  name,
  price,
  image,
  category_id
) VALUES (
  'Блюдо',
  1000.00,
  'https://e0.edimdoma.ru/data/posts/0002/1936/21936-ed4_wide.jpg?1679398231',
  2
);
        ''');
      
    }, singleInstance: true);
    return database;
  }
}
