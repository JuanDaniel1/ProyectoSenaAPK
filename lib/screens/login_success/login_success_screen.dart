import 'package:flutter/material.dart';

import 'components/body.dart';

// Pagina de mensaje login exitoso

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Login Cumplido", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Body(),
    );
  }
}
