import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/config.dart';

class Envios extends StatefulWidget {
  const Envios({super.key});

  @override
  State<Envios> createState() => _EnviosState();
}

class _EnviosState extends State<Envios> {
  final TextEditingController productoname = TextEditingController();
  final TextEditingController shippedController = TextEditingController();
  List<String> _productos = [];
  String _productoSeleccionado = ''; // Lista para almacenar los productos desde la API





  Future<void> postData() async {
    final url = "https://juandaniel1.pythonanywhere.com/api/envioscomerc/"; // Reemplaza esto con la URL de tu API
    final response = await http.post(
      Uri.parse(url),
      body: {
        'nombre': productoname.text,
        'enviado': shippedController.text,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Si la solicitud fue exitosa
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Datos enviados con éxito'),
          duration: Duration(seconds: 2),
        ),
      );
      // Limpiar los campos de texto
      shippedController.clear();
    } else {
      // Si hubo un error en la solicitud
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar datos'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: productoname,
            decoration: InputDecoration(labelText: 'Nombre'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: shippedController,
            decoration: InputDecoration(labelText: 'Envíos'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              postData();
            },
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
