import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/menuAdmin.dart';
import 'package:shop_app/menucomerc.dart';

import '../../menu.dart';
import '../../usuario.dart';
import 'components/body.dart';

// Pantalla de home

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final User? user = snapshot.data;
            if (user != null) {
              if(user.email == "comerc@gmail.com"){
                return MenuComerc();
              } else if(user.email == "admin@gmail.com"){
                return MenuAdmin();
              } else if(user.email == "jefe@gmail.com"){
                return MenuTutor();
              }
              else{
                return SizedBox.shrink();
              }
            } else {
              // El usuario no ha iniciado sesión
              return SizedBox.shrink();
            }
          } else {
            // Mostrar un indicador de carga mientras se verifica el estado de autenticación
            return CircularProgressIndicator();
          }
        },
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
