import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shoppinglist_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class ShoppingListItem extends StatelessWidget{
  bool inCart = false;
  final Product product;
  final CartChangeCallback onCartChanged;

  ShoppingListItem({Key? key,
    required this.inCart,
    required this.product,
    required this.onCartChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('shoppingListItem ${product.name} build');
    return GetBuilder<ShoppingListController>(
      builder: (_) {
        return ListTile(
          onTap: () {
            onCartChanged(product, inCart);
            inCart = ShoppingListController.to.isInCart(product);
          },
          leading: CircleAvatar(
            backgroundColor: _getColor(context),
          ),
          title: Text(product.name, style: _getTextStyle(),),
        );
      }
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

class ShoppingList extends GetView<ShoppingListController> {
  List<Product> products = <Product>[];
  ShoppingList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ShoppingListController());
    print('shoppingList build');
    return ListView(
          children: products.map((product) {
            return ShoppingListItem(
                product: product,
                inCart: controller.isInCart(product),
                onCartChanged: controller.handleCartChanged);
          }).toList(),
        );
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
      body: Center(
        child: ShoppingList(products: [
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
        ],),
        ),
      );
  }
}
