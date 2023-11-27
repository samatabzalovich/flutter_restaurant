
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_text.dart';
import 'package:flutter_restaurant/view/home/screens/home.dart';
import 'package:flutter_restaurant/view/order/screen/order_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 110,
            child: DrawerHeader(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
              ),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Иван Иванович Иван",
                    ),
                    CustomText(
                      "Сотрудник",
                      fontSize: 12,
                    )
                  ]),
            ),
          ),
          ListTile(
            leading: Icon(Icons.sync),
            title: const Text('Синхронизация'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: const Text('Кассир'),
            onTap: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OrderPage()), (route)=> false);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Официант'),
            onTap: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route)=> false);
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: const Text('Режим продаж'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt_sharp),
            title: const Text('Склад'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Сменить сотрудника'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
