import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/orders.dart';
import 'package:shoppinggu/ui/widgets/app_drawer.dart';
import 'package:shoppinggu/ui/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const route = "/orders";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: orders.orders.length,
          itemBuilder: (ctx, index) => OrderListItem(
            order: orders.orders[index],
          ),
        ),
      ),
    );
  }
}
