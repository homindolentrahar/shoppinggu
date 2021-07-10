import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoppinggu/ui/screens/orders_screen.dart';
import 'package:shoppinggu/ui/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Happy Shopping!"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Ionicons.storefront),
            title: Text("Shop"),
            onTap: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
          ListTile(
            leading: Icon(Ionicons.bag_handle),
            title: Text("Orders"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(OrdersScreen.route),
          ),
          Divider(),
          ListTile(
            leading: Icon(Ionicons.cube),
            title: Text("Manage Products"),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              UserProductsScreen.route,
            ),
          ),
        ],
      ),
    );
  }
}
