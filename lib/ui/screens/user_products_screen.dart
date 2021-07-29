import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/products.dart';
import 'package:shoppinggu/ui/screens/edit_product_screen.dart';
import 'package:shoppinggu/ui/widgets/app_drawer.dart';
import 'package:shoppinggu/ui/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Products"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.route);
              },
              icon: const Icon(Ionicons.add),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () => _refreshProducts(context),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.items.length,
            itemBuilder: (ctx, index) {
              return UserProductItem(
                product: products.items[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
