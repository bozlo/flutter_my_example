import 'package:flutter/material.dart';
import 'shoppinglist_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
      const ProviderScope(
        child: MyApp()
      )
  );
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

final shoppinglistProvider = StateNotifierProvider<ProductList, Set<Product>>((ref) {
  return ProductList(const {
      Product(name: 'Eggs'),
      Product(name: 'Flour'),
      Product(name: 'Chocolate chips'),
   });
});

final shoppingList = Provider<Set<Product>>((ref) => ref.watch(shoppinglistProvider);


class ShoppingListItem extends StatelessWidget{

  final product = <Product>{};

  ShoppingListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('shoppingListItem build');
    final products = ref.watch(shoppingList);

    return Consumer( builder: (context, ref, _) {
        return ListTile(
          onTap: () {
            ref.read(ShoppinglistProvider.notifier).toggle(product.name);
          },
          leading: CircleAvatar(
            backgroundColor: _getColor(context, ref),
          ),
          title: Text(product.name, style: _getTextStyle(ref),),
          );
      }
    );
  }

  Color _getColor(BuildContext context, ref) {
    return product.isCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(ref) {
    if (!product.isCart)  return null;
    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough
    );
  }
}

class ShoppingList extends ConsumerWidget {

  ShoppingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final products = ref.watch(shoppingList);
    print('shoppingList build');
    return ListView(
          children: products.map((product) {
            return ShoppingListItem(
                product: product);
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

        ],),
        ),
      );
  }
}
