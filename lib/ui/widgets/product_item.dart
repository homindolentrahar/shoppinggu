import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/cart.dart';
import 'package:shoppinggu/providers/product.dart';
import 'package:shoppinggu/ui/screens/product_detail_screen.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.route,
          arguments: product.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GridTile(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      color: ColorPalette.black,
                      borderRadius: BorderRadius.circular(360),
                      child: Consumer<Product>(
                        builder: (ctx, product, child) => InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              product.isFavorite
                                  ? Ionicons.heart
                                  : Ionicons.heart_outline,
                              color: product.isFavorite
                                  ? ColorPalette.red
                                  : ColorPalette.light,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(360),
                          onTap: () {
                            product.toggleFavorite();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: ColorPalette.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: ColorPalette.white),
                              ),
                              Text(
                                product.price.toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: ColorPalette.light),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Ionicons.cart_outline,
                                color: ColorPalette.dark,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              cart.addItem(product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
