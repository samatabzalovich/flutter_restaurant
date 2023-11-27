// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/order.dart';
import 'package:flutter_restaurant/dependency_injection.dart';
import 'package:flutter_restaurant/models/order.dart';

import 'package:flutter_restaurant/models/order_item.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_text.dart';

class SelectedItemsListView extends StatefulWidget {
  final List<OrderItem> orderItem;
  final String tableName;
  const SelectedItemsListView({
    Key? key,
    required this.orderItem,
    required this.tableName,
  }) : super(key: key);

  @override
  State<SelectedItemsListView> createState() => _SelectedItemsListViewState();
}

class _SelectedItemsListViewState extends State<SelectedItemsListView> {
  late double price;
  @override
  Widget build(BuildContext context) {
    price = 0;
    for (var element in widget.orderItem) {
      price += element.price * element.amount;
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: widget.orderItem.isEmpty
          ? const Center(
              child: CustomText("Выберите блюдо"),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.orderItem.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              widget.orderItem[index].item.name,
                              fontSize: 15,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.orderItem[index].amount++;
                                    });
                                  },
                                  icon: Icon(Icons.add_circle_outline),
                                  color: Colors.green,
                                ),
                                CustomText(
                                    widget.orderItem[index].amount.toString()),
                                IconButton(
                                    onPressed: () {
                                      if (widget.orderItem[index].amount <= 1) {
                                        setState(() {
                                          widget.orderItem.removeAt(index);
                                        });
                                      } else {
                                        setState(() {
                                          widget.orderItem[index].amount--;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.remove_circle_outline),
                                    color: Colors.red)
                              ],
                            )
                          ],
                        );
                      }),
                ),
                _orderButtonBuilder()
              ],
            ),
    );
  }

  Widget _orderButtonBuilder() {
    return ElevatedButton(
        onPressed: () async {
          final id = await sl<OrderDB>().insertOrder(Order(
              id: 0,
              tableName: widget.tableName,
              orderItems: widget.orderItem,
              createdAt: DateTime.now(),
              price: price));
          await sl<OrderDB>().insertOrderItems(id, widget.orderItem);
          setState(() {
            widget.orderItem.clear();
          });
        },
        child: CustomText("Создать заказ ${price.toStringAsFixed(2)}"));
  }
}
