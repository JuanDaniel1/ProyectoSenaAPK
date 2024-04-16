import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_app/config.dart';
import 'package:shop_app/pages/producto/producto_add_edit.dart';
import 'package:shop_app/services/api_popular.dart';
import '../../models/popular_model.dart';
import '../../models/producto_model.dart';
class ProductoItem extends StatefulWidget {
  final ProductoModel? model;
  final PopularModel? popular;
  final Function? onDelete;

  const ProductoItem({super.key, this.model, this.onDelete, this.popular});

  @override
  State<ProductoItem> createState() => _ProductoItemState();
}

class _ProductoItemState extends State<ProductoItem> {
  // Resto del código de la clase



  // Resto del código de la clase


  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: cartItem(context),
      ),
    );
  }
  Widget cartItem(context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 120,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child:  Stack(
              children: [
                Image.network(
                  widget.model!.productoImage!,
                  height: 70,
                  fit: BoxFit.scaleDown,
                ),


              ],
            )

        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model!.productoName!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.model!.productoPrice}",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ProductoAddEdit.routeName,
                          arguments: {
                            'model': widget.model,
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        widget.onDelete!(widget.model);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
  void save() {
    // URL del servidor al que deseas enviar la solicitud POST

    // Obtener el ID del producto actual (si está disponible)


    // Si isHovering es verdadero, el usuario activó la estrella y quieres agregar el producto a populares
    if (_isHovering) {
      // Preparar los datos del producto a enviar en la solicitud POST
      Map<String, dynamic> data = {
        "productoName": widget.model!.productoName,
        "productoImagen": widget.model!.productoImage,
        "productoPrice": widget.model!.productoPrice,
      };

      // Realizar la solicitud POST al servidor
      http.post(
        Uri.parse('https://juandaniel1.pythonanywhere.com/api/producto-popular/'),
        body: json.encode(data),
        headers: {"Content-Type": "application/json"},
      ).then((response) {
        // Si la solicitud fue exitosa, puedes mostrar un mensaje al usuario
        if (response.statusCode == 200) {
          print("Producto agregado a populares correctamente");



        } else {
          print("Error al agregar el producto a populares");
        }
      }).catchError((error) {
        print("Error al realizar la solicitud POST: $error");
      });
    }
  }




}

