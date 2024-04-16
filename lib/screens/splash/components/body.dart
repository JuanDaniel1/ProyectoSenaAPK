import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/menuAdmin.dart';
import 'package:shop_app/menuEncargado.dart';
import 'package:shop_app/menucomerc.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';

import '../../../menu.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

// Cuerpo del Splash

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  User? user = FirebaseAuth.instance.currentUser;
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenido a Tienda SENA!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Nosotros ofrecemos gran variedad de productos \npara la satisfaccion de nuestros clientes",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Mostramos calidad \ncon nuestro corazon",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    double size = 30;
    double fosize = 20;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      size = 40; // Cambia el crossAxisCount para pantallas más grandes
      fosize = 25;
    } else if (screenWidth >= 1000) {
      size = 50;
      fosize = 30;
    }
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Spacer(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => AnimatedContainer(
                          duration: kAnimationDuration,
                          margin: EdgeInsets.only(right: 5),
                          height: 6,
                          width: currentPage == index ? 20 : 6,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? kPrimaryColor
                                : Color(0xFFD8D8D8),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continua",
                      press: () {
                        if(user?.email == "jefe@gmail.com"){
                          Navigator.pushNamed(context, MenuTutor.routeName);
                        } else if(user?.email == "comerc@gmail.com"){
                          Navigator.pushNamed(context, MenuComerc.routeName);
                        } else if(user?.email == "admin@gmail.com"){
                          Navigator.pushNamed(context, MenuAdmin.routeName);
                        } else if(user?.email == "encarg@gmail.com"){
                          Navigator.pushNamed(context, MenuEncarg.routeName);
                        }
                        else {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        }

                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
