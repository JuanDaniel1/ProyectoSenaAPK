import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// Contenido de Splash, mensajes, imagenes, etc

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: <Widget>[
        Spacer(),
        Text(
          "SENA",
          style: TextStyle(
            fontSize: 50,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: 300,
          width: 300,
        ),
      ],
    );
  }
}
