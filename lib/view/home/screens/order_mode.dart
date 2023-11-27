// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/category_db_helper.dart';
import 'package:flutter_restaurant/data/item_db_helper.dart';

import 'package:flutter_restaurant/data/order.dart';
import 'package:flutter_restaurant/dependency_injection.dart';
import 'package:flutter_restaurant/models/category.dart';
import 'package:flutter_restaurant/models/item.dart';
import 'package:flutter_restaurant/models/order_item.dart';
import 'package:flutter_restaurant/view/common/widgets/custom_text.dart';
import 'package:flutter_restaurant/view/home/widgets/item_list_view.dart';

class OrderMode extends StatefulWidget {
  OrderMode({super.key, required this.tableName});
  final String tableName;

  @override
  State<OrderMode> createState() => _OrderModeState();
}

class _OrderModeState extends State<OrderMode> {
  int? selectedCategoryId;
  List<OrderItem> orderItems = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Режим Продаж"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Товары',
              ),
              Tab(
                text: 'Параметры',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SelectedItemsListView(
                    orderItem: orderItems,
                    tableName: widget.tableName,
                  ),
                  Expanded(
                    child: selectedCategoryId == null
                        ? _categoryGridViewBuilder()
                        : _itemsGridViewBuilder(),
                  )
                ],
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Category>> _categoryGridViewBuilder() {
    return FutureBuilder(
        future: sl<CategoryDBHelper>().getCategories(),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the number of columns as needed
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return _categoryBuilder(snapshot.data![index]);
              });
        });
  }

  Widget _itemsGridViewBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                selectedCategoryId = null;
              });
            },
            icon: Icon(Icons.arrow_back_ios)),
        Expanded(
          child: FutureBuilder(
              future: sl<ItemDBHelper>().getItems(selectedCategoryId!),
              builder: (context, AsyncSnapshot<List<Item>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          2, // Adjust the number of columns as needed
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _itemBuilder(snapshot.data![index]);
                    });
              }),
        ),
      ],
    );
  }

  Card _categoryBuilder(Category category) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategoryId = category.id;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: CustomText(
              category.name,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(Item item) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          final indexOfItem =
              orderItems.indexWhere((element) => element.item.id == item.id);
          if (indexOfItem != -1) {
            setState(() {
              orderItems[indexOfItem].amount++;
              orderItems[indexOfItem].price += orderItems[indexOfItem].price;
            });
          }else {
            setState(() {
            orderItems
              .add(OrderItem( item: item, amount: 1, price: item.price!));
          });
          }
          
        },
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Image.network(item.image),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          item.price.toString(),
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          "Склад:${item.amount}",
                          fontSize: 12,
                        )
                      ],
                    ),
                  ],
                ),
                CustomText(item.name)
              ],
            )),
      ),
    );
  }
}
