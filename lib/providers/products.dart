import 'package:flutter/widgets.dart';
import 'package:shoppinggu/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//103/MTA-11949565/wellborn_company_wellborn_ss_carved_red_t-shirt_full01_en8psmih.jpg'),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://assets.myntassets.com/fl_progressive/h_960,q_80,w_720/v1/assets/images/6993400/2018/7/30/b3d5f951-1149-4217-81a9-f50cb646fa3f1532928738800-PANIT-Women-Trousers-6611532928738642-1.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://target.scene7.com/is/image/Target/GUEST_458a8723-a558-4c34-8bdb-513a05c87b6a?wid=488&hei=488&fmt=pjpeg'),
  ];

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  List<Product> get items => [..._items];

  Product findProductById(String productId) {
    return _items.firstWhere((prod) => prod.id == productId);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String productId, Product product) {
    final prodIndex = _items.indexWhere((prod) => prod.id == productId);
    if (prodIndex >= 0) {
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _items.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
