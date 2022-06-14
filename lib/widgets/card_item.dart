import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Dismissible(
          key: Key(id),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text("So you want this product has removed?"),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Yes")),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("No")),
                      ],
                    ));
          },
          onDismissed: (direction) {
            Provider.of<Cart>(context, listen: false).deleteItem(productId);
          },
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              size: 25,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(child: Text("$price TL")),
            )),
            title: Text(title),
            subtitle: Text("Total: ${price * quantity} TL"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
