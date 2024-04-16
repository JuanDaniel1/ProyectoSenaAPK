import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/pages/categoria/categoria_list.dart';
import 'package:shop_app/pages/cliente/cliente_list.dart';
import 'package:shop_app/pages/populares/producto_list.dart';
import 'package:shop_app/pages/producto/producto_list.dart';
import 'package:shop_app/pages/inicio/inicio.dart';
import 'package:shop_app/screens/administrador/enviados/bar_chart.dart';
import 'package:shop_app/screens/home/home_screen.dart';



class MenuAdmin extends StatefulWidget {
  static String routeName = "/adminis";

  const MenuAdmin({super.key});
  @override
  MenuAdminState createState() => MenuAdminState();
}

class MenuAdminState extends State<MenuAdmin> {

  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return GraficaEnvio();
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
        title: const Text("Admin"),
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
              title: const Text('Envios Reporte'),
              leading: const Icon(Icons.bar_chart_sharp),
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