import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/products.dart';
import 'package:shoppinggu/ui/themes/theme.dart';
import 'package:shoppinggu/ui/widgets/app_back_button.dart';
import 'package:shoppinggu/ui/widgets/secondary_action_button.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findProductById(productId);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                colors: [
                  ColorPalette.black,
                  ColorPalette.black.withOpacity(0.5),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(rect),
              blendMode: BlendMode.srcATop,
              child: Hero(
                tag: productId,
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              bottom: 32,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBackButton(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: ColorPalette.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: ColorPalette.light),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\$",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: ColorPalette.white),
                            ),
                            TextSpan(
                              text: product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(color: ColorPalette.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SecondaryActionButton(
                        iconData: Ionicons.cart,
                        text: "Add to Cart",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
