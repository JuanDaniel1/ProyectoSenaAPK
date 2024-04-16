import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/menu.dart';
import 'package:shop_app/menuAdmin.dart';
import 'package:shop_app/menuEncargado.dart';
import 'package:shop_app/menucomerc.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../components/default_button.dart';
import '../../../config.dart';
import '../../../constants.dart';
import '../../../services/firebase_auth_services.dart';
import '../../../size_config.dart';
import '../../../usuario.dart';
import 'package:http/http.dart' as http;

// Formulario para iniciar sesion

class SignForm extends StatefulWidget {

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //final urllogin = Uri.parse("http://192.168.1.108/api/login/");
  final urllogin = Uri.parse("${Config.apiURL}${Config.loginAPI}");

  //final urlobtenertoken = Uri.parse("http://192.168.1.108/api/api-token-auth/");
  final urlobtenertoken = Uri.parse("${Config.apiURL}${Config.obtenertokenAPI}");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            child: buildEmailFormField(),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(30)
            ),

          ),



          SizedBox(height: 30),
          Container(
            child: buildPasswordFormField(),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30)
            ),

          ),
          SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Recuerdame", style: TextStyle(color: Colors.white),),
              Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Olvide la contrasena",
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.white),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: 30),
          DefaultButton(
            text: "Continua",
            press: () {
              _signIn();
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Digita tu contrasena",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Digita tu email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void showSnackbar(String msg) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<void> login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(
          "${nameController.text.isEmpty ? "-User " : ""} ${passwordController
              .text.isEmpty ? "- Contraseña " : ""} requerido");
      return;
    }
    final datosdelposibleusuario = {
      "username": nameController.text,
      "password": passwordController.text
    };
    final res = await http.post(urllogin,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    //final data = Map.from(jsonDecode(res.body));
    if (res.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res.statusCode != 200) {
      showSnackbar("Ups ha habido un al obtener usuario y contraseña ");
    }
    final res2 = await http.post(urlobtenertoken,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    final data2 = Map.from(jsonDecode(res2.body));
    if (res2.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res2.statusCode != 200) {
      showSnackbar("Ups ha habido al obtener el token ");
    }
    final token = data2["token"];
    final user = Usuario(
        username: nameController.text,
        password: passwordController.text,
        token: token);
    // ignore: use_build_context_synchronously
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
    // ignore: use_build_context_synchronously
    if (user.username == "tutor@gmail.com") {
      Navigator.pushNamed(
          context, MenuTutor.routeName
      );
    } else if (user.username == "comerc@gmail.com") {
      Navigator.pushNamed(context, MenuComerc.routeName);
    } else if (user.username == "jefe@gmail.com") {
      Navigator.pushNamed(context, MenuTutor.routeName);
    } else if(user.username == "admin@gmail.com") {
      Navigator.pushNamed(context, MenuAdmin.routeName);
    }
    else {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }
  void _signIn() async {
    String email = nameController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);


    if(user != null) {
      print("usuario creado");
      if(email == "admin@gmail.com"){
        Navigator.pushNamed(context, MenuAdmin.routeName);
      } else if(email == "comerc@gmail.com"){
        Navigator.pushNamed(context, MenuComerc.routeName);
      } else if(email == "jefe@gmail.com"){
        Navigator.pushNamed(context, MenuTutor.routeName);
      } else if(email == "encarg@gmail.com"){
        Navigator.pushNamed(context, MenuEncarg.routeName);
      }
      else {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }

    } else {
      print("error");
    }
  }
}

const TextStyle Kmail = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.white
);