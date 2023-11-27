import 'package:flutter/material.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_drawer.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_text.dart';
import 'package:flutter_restaurant/view/home/screens/order_mode.dart';
import 'package:flutter_restaurant/view/order/screen/order_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final List<String> tableName = const ["vip 1", "vip 2"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Выбор"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width / 2.5,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: CustomText(
                  "Основной зал",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => OrderMode(
                            tableName: tableName[0],
                          )));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(Icons.receipt),
                      Expanded(
                          child: CustomText(
                        tableName[0],
                        align: TextAlign.center,
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width / 2.5,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange.withOpacity(0.5)),
                child: CustomText("Летка"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => OrderMode(
                            tableName: tableName[1],
                          )));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(Icons.receipt),
                      Expanded(
                          child: CustomText(
                        tableName[1],
                        align: TextAlign.center,
                      ))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
