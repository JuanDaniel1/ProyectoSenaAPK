import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../models/producto_model.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 60,
    this.aspectRetio = 1.02,
    this.model,
  }) : super(key: key);
  final double width, aspectRetio;
  final ProductoModel? model;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHover = false;
  Offset mousPos = new Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    double size = 20;
    double minsize = 15;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      size = 24; // Cambia el crossAxisCount para pantallas más grandes
      minsize = 18;
    } else if (screenWidth >= 1000) {
      size = 26;
      minsize = 21;
    }
    return Padding(
      padding: EdgeInsets.all(5 ),
      child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.green,
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0,6)
                  ),
                  BoxShadow(
                      color: Colors.green,
                      spreadRadius: -4,
                      blurRadius: 5,
                      offset: Offset(6,0)
                  )
                ]),
            child:  SizedBox(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(model: widget.model),
                ),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      AspectRatio(
                      aspectRatio: 1.02,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: kSecondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(widget.model!.productoImage!, fit: BoxFit.cover,),

                          ),




              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  widget.model!.productoName!,
                  style: GoogleFonts.truculenta(fontSize: size, fontWeight: FontWeight.w300, color: Colors.black),
                  maxLines: 2,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "\$${widget.model!.productoPrice}",
                                style: GoogleFonts.truculenta(fontSize: size, fontWeight: FontWeight.w400, color: kPrimaryColor)
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Cantidad: ${widget.model!.productoCantidad}",
                              style: GoogleFonts.truculenta(fontSize: minsize, fontWeight: FontWeight.w300, color: Colors.black),
                            )
                          ],
                        )

                      ],
                    ),


                  )
                ],
              )



              ],
            ),
          )

      ),
    ),
    ),

    )

    );
  }

}






