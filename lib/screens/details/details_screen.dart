import 'package:flutter/material.dart';

import '../../models/Product.dart';
import '../../models/producto_model.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

// Pantalla de detalles de productos

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      body: Body(model: agrs.model),
    );
  }
}

class ProductDetailsArguments {
  final ProductoModel? model;

  ProductDetailsArguments({required this.model});
}
