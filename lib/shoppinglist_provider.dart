import 'package:riverpod/riverpod.dart';

class Product {
  const Product({required this.name, this.isCart = false});

  final String name;
  bool isCart;

  @override
  String toString() {
    return name;
  }
}

class ProductList extends StateNotifier<Set<Product>> {
  ProductList(Set<Product>? initialProduct) : super(initialProduct ?? {});

  void toggle(String name) {
    state = {
      for (final p in state)
        if (p.name == name)
          Product(name: name, isCart: !p.isCart);
        else
          p,
    };
  }

  bool isInCart(name) {
    return state.contains(name);
  }
}

