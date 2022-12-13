///Sử dụng phương thức setState() để thay đổi trạng thái widget
///final shoppingCart = <Product>{}
///void handleCartChange(Product product, bool inCart)
///---if(inCart) shoppingCart.remove(product)
///---if(!inCart) shoppingCart.add(product)
///Widget build(Context context)
///---shoppingCart.product.map((product)
///------return ShoppingListItem(
///---------product,
///---------shoppingList.contain(product),
///---------handleCartChange,

import 'package:flutter/material.dart';

class Product {
  const Product({required this.name});
  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key : ObjectKey(product));
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;
  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }
  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () { onCartChanged(product, inCart); },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0], style: const TextStyle(fontWeight: FontWeight.bold,)),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class AShoppingList extends StatefulWidget {
  final List<Product> products;
  const AShoppingList({
    required this.products,
    super.key
  });
  @override
  State<AShoppingList> createState() => _AShoppingListState();
}

class _AShoppingListState extends State<AShoppingList> {
  final _shoppingCart = <Product>{};
  void _handleCartChange(Product product, bool inCart)
  {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      }
      else {
        _shoppingCart.remove(product);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List'),),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChange,
          );
        }).toList(),
      ),
    );
  }
}