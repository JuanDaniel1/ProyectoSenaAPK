import 'package:flutter/material.dart';

import '../../../size_config.dart';

// Diseno de cada titulo en cada seccion de home

class SectionTitle extends StatelessWidget {

  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double size = 35;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      size = 45; // Cambia el crossAxisCount para pantallas más grandes
    } else if (screenWidth >= 1000) {
      size = 55;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size,
            color: Colors.black,
          ),
        ),

      ],
    );
  }
}
