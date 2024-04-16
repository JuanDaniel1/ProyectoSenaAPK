import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../models/popular_model.dart';
import '../../../models/producto_model.dart';
import '../../../size_config.dart';

// Imagen de productos en detalles

class PopularImages extends StatefulWidget {
  const PopularImages({
    Key? key,
    required this.model,
  }) : super(key: key);

  final String model;

  @override
  _PopularImagesState createState() => _PopularImagesState();
}

class _PopularImagesState extends State<PopularImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,

              child: Image.network(widget.model),

          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),

      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.model, fit: BoxFit.cover,),
      ),
    );
  }
}
