import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_shop_app/providers/cart.dart';
import 'package:sm_shop_app/providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/ProductDetail', arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, value, child) => SizedBox(
              height: 18.0,
              width: 25.0,
              child: IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: SizedBox(
            height: 18.0,
            width: 25.0,
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(Icons.shopping_basket),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("This item added in your cart."),
                    action: SnackBarAction(label: "Undo", onPressed: () {
                      cart.removeSingleItem(product.id);
                    }),
                  ),
                );
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
