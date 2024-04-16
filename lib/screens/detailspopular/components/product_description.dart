import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/popular_model.dart';

import '../../../constants.dart';
import '../../../models/producto_model.dart';
import '../../../size_config.dart';

// Seccion de descripcion de productos en detalles

class PopularDescription extends StatelessWidget {
  const PopularDescription({
    Key? key,
    this.pressOnSeeMore, required this.description, required this.name,
  }) : super(key: key);

  final String description;
  final String name;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
        )
      ],
    );
  }
}
