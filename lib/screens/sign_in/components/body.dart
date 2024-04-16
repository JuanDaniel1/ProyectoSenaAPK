import 'package:flutter/material.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';




import '../../../size_config.dart';
import 'sign_form.dart';

// Cuerpo para iniciar Sesion

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
     SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Bienvenido!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Inicia Sesion con tu correo y contrasena ", style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                SignForm(),
                SizedBox(height: 20),
                IconButton(onPressed: (){


                }, icon: Icon(Icons.camera)),
                SizedBox(height: 30),
                NoAccountText(),
              ],
            ),
          ),
        ),
      );

  }
}
