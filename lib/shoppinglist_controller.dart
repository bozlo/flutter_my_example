import 'package:get/get.dart';

class Product {
  final String name;
  const Product({required this.name});
}

typedef CartChangeCallback = Function(Product product, bool inCart);

class ShoppingListController extends GetxController {
  static ShoppingListController get to => Get.find();

  var _shoppingCart = <Product>{};

  bool isInCart(Product product) {
    return _shoppingCart.contains(product);
  }

  void handleCartChanged(Product product, bool inCart) {
    if (!inCart) {
      _shoppingCart.add(product);
    } else {
      _shoppingCart.remove(product);
    }
    update();
  }
}