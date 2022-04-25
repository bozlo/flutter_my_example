import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Product {
  final String name;
  const Product({required this.name});
}

typedef CartChangeCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  final bool inCart;
  final Product product;
  final CartChangeCallback onCartChanged;

  const ShoppingListItem({Key? key,
    required this.inCart,
    required this.product,
    required this.onCartChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('shoppingListItem ${product.name} build');
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
      ),
      title: Text(product.name, style: _getTextStyle(),),
    );
  }
  Color _getColor(BuildContext context) {
    return inCart? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle() {
    if (!inCart)  return null;
    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough
    );
  }
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;
  const ShoppingList({Key? key, required this.products}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  @override
  Widget build(BuildContext context) {
    print('shoppingList build');
    return ListView(
      children: widget.products.map((product) {
        return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged);
      }).toList(),
    );
  }

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }
}



class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),),
      body: const Center(
        child: ShoppingList(products: [
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
        ],),
        ),
      );
  }
}
