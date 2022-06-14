import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_shop_app/providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/card_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(
                      "${cartData.totalAmount} TL",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrders(
                            cartData.items.values.toList(),
                            cartData.totalAmount);
                        cartData.clear();
                      },
                      child: Text("ORDER NOW")),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: ((context, index) => CartItem(
                    cartData.items.values.toList()[index].id,
                    cartData.items.keys.toList()[index],
                    cartData.items.values.toList()[index].price,
                    cartData.items.values.toList()[index].quantity,
                    cartData.items.values.toList()[index].title,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
