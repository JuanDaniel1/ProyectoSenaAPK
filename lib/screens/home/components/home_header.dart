import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'dart:io' show Platform;

// Encabezado de aplicacion donde se ubica buscador, escaner, carro de compras

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          FutureBuilder<User?>(
              future: FirebaseAuth.instance.authStateChanges().first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final User? user = snapshot.data;
                  if (user != null) {
                    return IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () => Navigator.pushNamed(context, CartScreen.routeName),
                    );
                  } else {
                    return IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () => Navigator.pushNamed(context, SignInScreen.routeName),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),


        ],
      ),
    );
  }
}
