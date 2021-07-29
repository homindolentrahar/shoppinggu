import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoppinggu/providers/product.dart';
import 'package:shoppinggu/providers/products.dart';
import 'package:shoppinggu/ui/themes/theme.dart';
import 'package:shoppinggu/ui/widgets/app_form_field.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _titleFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: "",
    description: "",
    price: 0,
    imageUrl: "",
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;

      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findProductById(productId.toString());
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _titleFocus.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false).updateProduct(
        _editedProduct.id.toString(),
        _editedProduct,
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("There was an error"),
                content: Text("Something went wrong!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Got It"),
                  )
                ],
              );
            });
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
          actions: [
            IconButton(
              icon: Icon(Ionicons.save),
              onPressed: _saveForm,
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: SpinKitChasingDots(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _imageUrlController.text.isEmpty
                            ? DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: [10, 15, 10, 15],
                                radius: Radius.circular(8),
                                color: ColorPalette.dark.withOpacity(0.75),
                                child: Container(
                                  width: 128,
                                  height: 128,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "No Image",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              color: ColorPalette.dark
                                                  .withOpacity(0.75)),
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  _imageUrlController.text.toString(),
                                  width: 128,
                                  height: 128,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        const SizedBox(height: 16),
                        AppFormField(
                          controller: _imageUrlController,
                          hintText: "Image URL",
                          icon: Ionicons.image,
                          keyboardType: TextInputType.url,
                          action: TextInputAction.next,
                          onEditingComplete: () {
                            setState(() {});
                            FocusScope.of(context).requestFocus(_titleFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter image URL!";
                            }
                            if (!value.startsWith('http') ||
                                !value.startsWith('https')) {
                              return "Please enter valid URL";
                            }
                            // if (!value.endsWith('.png') &&
                            //     !value.endsWith('.jpg') &&
                            //     !value.endsWith('.jpeg')) {
                            //   return "Please enter a valid image URL";
                            // }
                            // var urlPattern =
                            //     r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                            // var result = RegExp(urlPattern, caseSensitive: false)
                            //     .firstMatch(value.toString());

                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value.toString(),
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        AppFormField(
                          initialValue: _initValues['title'],
                          focusNode: _titleFocus,
                          hintText: "Title",
                          icon: Ionicons.text,
                          action: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please provide a title!";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              id: _editedProduct.id,
                              title: value.toString(),
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        AppFormField(
                          initialValue: _initValues['price'],
                          hintText: "Price",
                          icon: Ionicons.pricetag,
                          keyboardType: TextInputType.number,
                          action: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please provide a price!";
                            }

                            if (double.tryParse(value) == null) {
                              return "Please enter a valid number";
                            }

                            if (double.parse(value) <= 0) {
                              return "Please enter a number greater than zero";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: double.parse(value.toString()),
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        AppFormField(
                          initialValue: _initValues['description'],
                          hintText: "Description",
                          icon: Ionicons.newspaper,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          action: TextInputAction.newline,
                          onSubmit: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a description";
                            }
                            if (value.length < 10) {
                              return "Should be at least 10 characters long";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: value.toString(),
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
