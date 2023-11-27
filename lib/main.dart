import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/database_helper.dart';
import 'package:flutter_restaurant/dependency_injection.dart';
import 'package:flutter_restaurant/view/home/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await sl<DBProvider>().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}
