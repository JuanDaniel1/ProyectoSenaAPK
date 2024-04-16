import 'package:flutter/material.dart';
import 'package:shop_app/pages/populares/producto_list.dart';
import 'package:shop_app/screens/comercializadora/populares/producto_list.dart';
import 'package:shop_app/screens/comercializadora/producto/producto_list.dart';
import 'package:shop_app/screens/encargado/Envios.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class MenuEncarg extends StatefulWidget {
  static String routeName = "/encargado";
  const MenuEncarg({super.key});

  @override
  State<MenuEncarg> createState() => _MenuEncargState();
}

class _MenuEncargState extends State<MenuEncarg> {
  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return const Envios();


    }
  }
  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encargado Unidad"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('SENA'),
              accountEmail: Text('contaco@misena.edu.co'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logoxyz.png'),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.home),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Envios'),
              leading: const Icon(Icons.send_and_archive),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),

          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }

}
