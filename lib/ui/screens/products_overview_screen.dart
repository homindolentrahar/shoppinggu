import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/cart.dart';
import 'package:shoppinggu/providers/products.dart';
import 'package:shoppinggu/ui/screens/cart_screen.dart';
import 'package:shoppinggu/ui/themes/theme.dart';
import 'package:shoppinggu/ui/widgets/app_drawer.dart';
import 'package:shoppinggu/ui/widgets/badge.dart';
import 'package:shoppinggu/ui/widgets/product_item.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shoppinggu"),
          actions: [
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 1,
              onSelected: (FilterOptions value) {
                setState(() {
                  if (value == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Ionicons.filter),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              child: IconButton(
                icon: Icon(
                  Ionicons.cart,
                  color: ColorPalette.dark,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                },
              ),
              builder: (ctx, cart, child) => Badge(
                child: child!,
                value: cart.itemCount.toString(),
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Products>(context).fetchProducts(),
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
                  child: Text("Error occurred :("),
                );
              } else {
                return _ProductsGrid(
                  showFavs: _showOnlyFavorites,
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const _ProductsGrid({Key? key, required this.showFavs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (ctx, data, child) => GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3 / 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: data.items.length,
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: data.items[index],
            child: ProductItem(),
          );
        },
      ),
    );
  }
}
