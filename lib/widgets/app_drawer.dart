import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello My Comrade!"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Orders"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/orders");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.production_quantity_limits),
            title: const Text("Product Management"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/prod-manage");
            },
          ),
        ],
      )
    );
  }
}