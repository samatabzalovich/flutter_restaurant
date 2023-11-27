import 'package:flutter_restaurant/data/category_db_helper.dart';
import 'package:flutter_restaurant/data/database_helper.dart';
import 'package:flutter_restaurant/data/item_db_helper.dart';
import 'package:flutter_restaurant/data/order.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl
    ..registerSingleton(DBProvider())
    ..registerLazySingleton(() => OrderDB(sl()))
    ..registerLazySingleton(() => CategoryDBHelper(sl()))
    ..registerLazySingleton(() => ItemDBHelper(sl()))

    ;
}
