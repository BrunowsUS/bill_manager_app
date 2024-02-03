import 'package:flutter/material.dart';

class BillDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Atualize o estado do app
              // ...
              // Depois feche o drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Configurações'),
            onTap: () {
              // Atualize o estado do app
              // ...
              // Depois feche o drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
