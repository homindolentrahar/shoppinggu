import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/cart.dart';
import 'package:shoppinggu/providers/orders.dart';
import 'package:shoppinggu/providers/products.dart';
import 'package:shoppinggu/ui/screens/cart_screen.dart';
import 'package:shoppinggu/ui/screens/orders_screen.dart';
import 'package:shoppinggu/ui/screens/product_detail_screen.dart';
import 'package:shoppinggu/ui/screens/products_overview_screen.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoppinggu',
        theme: appTheme,
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
          CartScreen.route: (ctx) => CartScreen(),
          OrdersScreen.route: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
