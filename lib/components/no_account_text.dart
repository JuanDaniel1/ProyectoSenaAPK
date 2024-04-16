import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../screens/sign_up/registerScreen.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No tienes cuenta? ",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Register.routeName),
          child: Text(
            "Registrarse",
            style: TextStyle(
                fontSize: 30,
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
