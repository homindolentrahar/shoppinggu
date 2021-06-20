import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/cart.dart' show Cart;
import 'package:shoppinggu/providers/orders.dart';
import 'package:shoppinggu/ui/widgets/cart_item.dart';
import 'package:shoppinggu/ui/widgets/primary_action_button.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Ionicons.chevron_back),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\$",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextSpan(
                              text: cart.totalAmount.toString(),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Total Amount",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (ctx, index) {
                        return CartListItem(
                          productId: cart.items.keys.toList()[index],
                          cartItem: cart.items.values.toList()[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            PrimaryActionButton(
              iconData: Ionicons.cash,
              text: "Checkout",
              onPressed: () {
                Provider.of<Orders>(context, listen: false).addOrder(
                  cart.items.values.toList(),
                  cart.totalAmount,
                );
                cart.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
