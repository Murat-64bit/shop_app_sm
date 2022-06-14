import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_shop_app/providers/products.dart';
import 'package:sm_shop_app/widgets/app_drawer.dart';
import 'package:sm_shop_app/widgets/product_grid.dart';

import '../providers/cart.dart';
import '../widgets/badge.dart';

enum Filter {
  Favorites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (Filter selectedValue) {
              if (selectedValue == Filter.Favorites) {
                setState(() {
                  _showOnlyFavorites = true;
                });
                // prodContainers.truefilterFavorite();
              } else {
                setState(() {
                  _showOnlyFavorites = false;
                });
                // prodContainers.falsefilterFavorite();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("My Favorite's"),
                value: Filter.Favorites,
              ),
              PopupMenuItem(
                child: Text("All"),
                value: Filter.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, ref, ch) => Badge(
              child: ch!,
              color: Theme.of(context).colorScheme.secondary,
              value: ref.totalCart.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ProductGrid(_showOnlyFavorites),
    );
  }
}
