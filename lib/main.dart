import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_shop_app/providers/auth.dart';
import 'package:sm_shop_app/providers/cart.dart';
import 'package:sm_shop_app/providers/orders.dart';
import 'package:sm_shop_app/screens/auth_screen.dart';
import 'package:sm_shop_app/screens/cart_screen.dart';
import 'package:sm_shop_app/screens/edit_product_screen.dart';
import 'package:sm_shop_app/screens/orders_screen.dart';
import 'package:sm_shop_app/screens/product_management._screen.dart';
import '../providers/products.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', []),
            update: (ctx, auth, previousProducts) => Products(
              auth.token,previousProducts ==null ? [] : previousProducts.items,
            ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, value, child) => MaterialApp(
            theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
                    .copyWith(secondary: Colors.deepOrange),
                primaryColor: Colors.amber),
            title: 'Material App',
            home: value.isAuth ? ProductsOverViewScreen() : AuthScreen(),
            routes: {
              ProductDetail.routeName: (context) => ProductDetail(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              ProductManagementScreen.routeName: (context) =>
                  ProductManagementScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          ),
        ));
  }
}
