import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/pages/categoria/categoria_list.dart';
import 'package:shop_app/pages/cliente/cliente_list.dart';
import 'package:shop_app/pages/populares/producto_list.dart';
import 'package:shop_app/pages/producto/producto_list.dart';
import 'package:shop_app/pages/inicio/inicio.dart';
import 'package:shop_app/screens/home/home_screen.dart';



class MenuTutor extends StatefulWidget {
  static String routeName = "/jefenice";

  const MenuTutor({super.key});
  @override
  MenuTutorState createState() => MenuTutorState();
}

class MenuTutorState extends State<MenuTutor> {

  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return const CategoriasList();
      case 2:
        return const ProductosList();
      case 3:
        return const PopularList();
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
        title: const Text("Jefe"),
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
              title: const Text('Categorias'),
              leading: const Icon(Icons.category),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Productos'),
              leading: const Icon(Icons.production_quantity_limits),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),

          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }
}