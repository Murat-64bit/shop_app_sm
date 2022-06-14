import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_shop_app/widgets/app_drawer.dart';
import 'package:sm_shop_app/widgets/product_manage_item.dart';

import '../providers/products.dart';

class ProductManagementScreen extends StatelessWidget {
  static const routeName = '/prod-manage';

  Future<void> _OnRefresh(BuildContext context) async{
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Management System"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/edit-product",arguments: ' ');
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () =>_OnRefresh(context) ,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (ctx, i) => Column(
                    children: [
                      ProductManageItem(
                        productData.items[i].id,
                        productData.items[i].title,
                        productData.items[i].imageUrl,
                      ),
                      Divider(),
                    ],
                  )),
        ),
      ),
    );
  }
}
