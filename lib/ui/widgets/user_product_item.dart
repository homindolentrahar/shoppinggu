import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/product.dart';
import 'package:shoppinggu/providers/products.dart';
import 'package:shoppinggu/ui/screens/edit_product_screen.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(product.imageUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "\$${product.price}",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _ActionIconButton(
              icon: Ionicons.pencil,
              onTap: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.route,
                  arguments: product.id,
                );
              },
            ),
            const SizedBox(width: 8),
            _ActionIconButton(
              icon: Ionicons.trash,
              iconColor: ColorPalette.white,
              backgroundColor: ColorPalette.red,
              borderColor: ColorPalette.red,
              onTap: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProduct(product.id.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color splashColor;
  final VoidCallback onTap;

  const _ActionIconButton({
    Key? key,
    required this.icon,
    this.iconColor = ColorPalette.dark,
    this.backgroundColor = Colors.transparent,
    this.borderColor = ColorPalette.light,
    this.splashColor = ColorPalette.light,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: 1),
      ),
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: splashColor.withOpacity(0.5),
        highlightColor: splashColor.withOpacity(0.3),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: iconColor,
            size: 16,
          ),
        ),
      ),
    );
  }
}
