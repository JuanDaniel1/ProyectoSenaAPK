
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/config.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/cart/cart_screen.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/carrito_model.dart';
import '../../../size_config.dart';
import '../provider.dart';
import 'cart_card.dart';
import 'package:shop_app/screens/cart/factura/pdf_pages.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:open_file/open_file.dart';

// Cuerpo de carrito de compras

class Body extends StatefulWidget {
  const Body({super.key, this.cart});
  final CarritoModel? cart;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  @override
  Widget build(BuildContext context) {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);
    final productsPurchased =   shoppingCartProvider.listProductsPurchased;
            double total = productsPurchased!
                .map((carrito) => double.parse(carrito.subtotal!))
                .fold(0, (a, b) => a + b);
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: productsPurchased.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: Key(productsPurchased[index].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              setState(() {
                                productsPurchased.removeAt(index);
                              });
                              Navigator.pushReplacementNamed(context, CartScreen.routeName);
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(100),
                                  height: getProportionateScreenWidth(80),
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(10)),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                          productsPurchased[index].productoImage!),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productsPurchased[index].productoName!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(14)),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 10),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            "\$${productsPurchased[index].productoPrice}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    14)),
                                        children: [
                                          TextSpan(
                                              text:
                                                  " x${productsPurchased[index].counter}",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          12))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Text(
                                        "SubTotal",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    14)),
                                      ),
                                    ),
                                    Text(
                                      "\$${productsPurchased[index].subtotal}",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenWidth(15),
                        horizontal: getProportionateScreenWidth(30),
                      ),
                      // height: 174,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -15),
                            blurRadius: 20,
                            color: Color(0xFFDADADA).withOpacity(0.15),
                          )
                        ],
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: getProportionateScreenWidth(40),
                                  width: getProportionateScreenWidth(40),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/icons/receipt.svg"),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Total:\n",
                                    children: [
                                      TextSpan(
                                        text: "\$${total}",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(190),
                                  child: DefaultButton(
                                    text: "Comprar",
                                    press: () async {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> PdfPage(model: productsPurchased, total: total,)));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          }


}
