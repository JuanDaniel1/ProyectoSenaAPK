import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_app/services/api_popular.dart';
import '../../models/popular_model.dart';
class PopularItem extends StatefulWidget {
  final PopularModel? model;
  final Function? onDelete;

  const PopularItem({super.key, this.model, this.onDelete});

  @override
  State<PopularItem> createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
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




}

