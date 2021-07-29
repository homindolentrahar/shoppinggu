import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/orders.dart';
import 'package:shoppinggu/ui/widgets/app_drawer.dart';
import 'package:shoppinggu/ui/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const route = "/orders";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitChasingDots(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text("Error happened :("),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, data, child) => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.orders.length,
                    itemBuilder: (ctx, index) => OrderListItem(
                      order: data.orders[index],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
