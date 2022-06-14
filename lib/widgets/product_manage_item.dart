import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_shop_app/providers/products.dart';

class ProductManageItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductManageItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final messanger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/edit-product", arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () async {
                await Provider.of<Products>(context, listen: false)
                    .deleteProduct(id)
                    .catchError((_) {
                      messanger.showSnackBar(SnackBar(content: Text("Deleting failed",textAlign: TextAlign.center,)));
                    });
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
