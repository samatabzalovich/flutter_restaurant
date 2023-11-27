// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_restaurant/data/order.dart';
import 'package:flutter_restaurant/dependency_injection.dart';
import 'package:flutter_restaurant/models/order.dart';
import 'package:flutter_restaurant/models/order_item.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_drawer.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_text.dart';

class OrderDetails extends StatelessWidget {
  final Order order;
  const OrderDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Заказ №${order.id}",
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back))),
      body: FutureBuilder(
        future: sl<OrderDB>().getOrderItems(order),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderItem>> snapshot) {
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
                  onTap: () {},
                  style: ListTileStyle.list,
                  title: CustomText(data[index].item.name),
                  leading: SizedBox(
                      height: 50, child: Image.network(data[index].item.image)),
                  subtitle: CustomText(data[index].amount.toString()),
                  trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          "№$index",
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
