

import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/informacion/pag2_informacion.dart';



class Informacion extends StatelessWidget {
  static String routeName = "/informacion";
  Informacion({super.key, required this.title});


   final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Informacion"
        ),
      ),
      body: Carousel(),
    );
  }
}
