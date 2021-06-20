import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoppinggu/providers/orders.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem order;

  const OrderListItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var _expanded = false;

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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "x${widget.order.products.length}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: ColorPalette.dark),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${widget.order.amount}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMMMEd().format(widget.order.dateTime),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: Icon(
                    _expanded ? Ionicons.chevron_up : Ionicons.chevron_down,
                    color: ColorPalette.dark,
                  ),
                ),
              ],
            ),
            if (_expanded)
              Container(
                height: min(widget.order.products.length * 20 + 80, 160),
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: widget.order.products.length,
                  itemBuilder: (ctx, index) {
                    final product = widget.order.products[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
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
                                    "x${product.quantity}",
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
                                      product.title,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      "\$${product.price}",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${product.quantity * product.price}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
