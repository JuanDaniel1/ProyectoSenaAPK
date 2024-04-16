import 'package:flutter/material.dart';
import 'package:shop_app/models/popular_model.dart';

import '../../models/Product.dart';
import '../../models/producto_model.dart';
import 'package:shop_app/screens/detailspopular/components/body.dart';
import 'components/custom_app_bar.dart';

// Pantalla de detalles de productos

class DetailsPopularScreen extends StatelessWidget {
  static String routeName = "/detailspop";

  const DetailsPopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductPopularDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductPopularDetailsArguments;
    return Scaffold(
      body: Body(image: agrs.image, description: agrs.description, price: agrs.price, name: agrs.name, cantidad: agrs.cantidad, id: agrs.id),
    );
  }
}

class ProductPopularDetailsArguments {
  final int id;
  final String name;
  final int price;
  final String description;
  final String image;
  final String cantidad;

  ProductPopularDetailsArguments( {required this.name, required this.price, required this.description, required this.image, required this.cantidad, required this.id});
}
