import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'products.dart';
import 'Productos_populares.dart';

// Cuerpo de pagina Home en la aplicacion y se arma cada seccion

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            HomeHeader(),
            SizedBox(height: 30),
            Categories(),
            SpecialOffers(),
            SizedBox(height: 30),
            PopularProducts(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
