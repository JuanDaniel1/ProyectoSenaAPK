import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';

import '../../../components/rounded_icon_btn.dart';
import '../../../models/popular_model.dart';
import '../../../models/producto_model.dart';
import '../../cart/provider.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:http/http.dart' as http;

// Cuerpo de Detalles de cada producto

class Body extends StatefulWidget {
  final String image;
  final String description;
  final int price;
  final String name;
  final int id;
  final String cantidad;
  const Body({super.key, required this.image, required this.description, required this.price, required this.name, required this.cantidad, required this.id});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double total = 0.0;
  int counter = 1;
  void incrementCounter() {
    setState(() {
      if(counter < int.parse(widget.cantidad)) {
        counter++;
      }
    });
  }

  void decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);
    return ListView(
      children: [
        PopularImages(model: widget.image),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              PopularDescription(
                description: widget.description,
                name: widget.name,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
                          Text("\$${widget.price}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Spacer(),
                          RoundedIconBtn(
                            icon: Icons.remove,
                            press: () {decrementCounter();},
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Text(counter.toString()),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          RoundedIconBtn(
                            icon: Icons.add,
                            showShadow: true,
                            press: () {
                              incrementCounter();
                            },
                          ),
                        ],
                      ),
                    ),
                    TopRoundedContainer(
                        color: Color(0xFFFCBE0BA),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.15,
                                right: SizeConfig.screenWidth * 0.15,
                                bottom: getProportionateScreenWidth(40),
                                top: getProportionateScreenWidth(15),
                              ),
                              child: DefaultButton(
                                text: "Anadir a carrito",
                                press: () {
                                  int price = widget.price;
                                  int quantity = counter;
                                  int subtotal = price * quantity;
                                  shoppingCartProvider.listProductsPurchased.add(
                                      ProductoModel(
                                        id: widget.id,
                                        productoDescription: widget.description,
                                        productoPrice: widget.price.toString(),
                                        productoCantidad: widget.cantidad,
                                        productoName: widget.name,
                                        productoImage: widget.image,
                                        counter: counter.toString(),
                                        subtotal: subtotal.toString(),
                                      )
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Se agrego "${widget.name
                                          }" al carrito de compras'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              ),

                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.20,
                                  right: SizeConfig.screenWidth * 0.20,
                                  bottom: getProportionateScreenWidth(40),
                                  top: getProportionateScreenWidth(15),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: getProportionateScreenHeight(46),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white, shape:
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Atras",
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(13),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )

                            ),
                          ],
                        )

                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  void save() async{
    // URL del servidor al que deseas enviar la solicitud POST
    String url = "https://juandaniel1.pythonanywhere.com/api/carrito/";

    // Preparar los datos del producto a enviar en la solicitud POST
    Map<String, dynamic> data = {
      "nombre": widget.name,
      "imagen": widget.image,
      "preciounitario": widget.price,
      "cantidad": counter,

    };

    // Realizar la solicitud POST al servidor
    http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    ).then((response) {
      // Si la solicitud fue exitosa, puedes mostrar un mensaje al usuario
      if (response.statusCode == 200) {
        print("Producto guardado correctamente");
      } else {
        print("Error al guardar el producto");
      }
    }).catchError((error) {
      print("Error al realizar la solicitud POST: $error");
    });
  }
}







