import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/order.dart';
import 'package:flutter_restaurant/dependency_injection.dart';
import 'package:flutter_restaurant/models/order.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_drawer.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_text.dart';
import 'package:flutter_restaurant/view/order/screen/order_details.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
          title: Text(
            "Кассир",
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))]),
      body: FutureBuilder(
        future: sl<OrderDB>().getOrder(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: CustomText('Пусто'),
            );
          }
          final data = snapshot.data!;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OrderDetails(order: data[index])));
                  },
                  style: ListTileStyle.list,
                  leading: data[index].tableName == "vip 1"
                      ? const Icon(Icons.receipt)
                      : const Icon(Icons.print),
                  title: CustomText(
                    "Посетитель",
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                  ),
                  subtitle: CustomText("Тапчан ${data[index].tableName}"),
                  trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          "№${data[index].id} ${data[index].createdAt.hour}:${data[index].createdAt.minute}",
                          fontSize: 10,
                        ),
                        CustomText(data[index].price.toStringAsFixed(2))
                      ]),
                );
              });
        },
      ),
    );
  }
}
