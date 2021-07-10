import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/cart.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartListItem({
    Key? key,
    required this.productId,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorPalette.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Ionicons.trash,
              color: ColorPalette.light,
            ),
            const SizedBox(width: 8),
            Text(
              "Delete",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: ColorPalette.light),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "Delete item",
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Text(
              "Do you want to remove the item from the cart?",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                  "No",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: ColorPalette.dark),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                  "Yes",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: ColorPalette.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorPalette.dark,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "x ${cartItem.quantity}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: ColorPalette.light),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          "\$${cartItem.price}",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "\$${cartItem.quantity * cartItem.price}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
