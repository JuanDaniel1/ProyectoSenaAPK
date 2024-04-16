

import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/cart/cart_screen.dart';
import '../../../constants.dart';
import '../../../models/carrito_model.dart';
import '../../../size_config.dart';

// Card de cada producto en carro de compras

class CartCard extends StatefulWidget {
  const CartCard({super.key, required this.cart});
  final CarritoModel cart;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  Future<void> deleteCarrito() async {
    try {
      final response = await http.delete(
        Uri.parse('https://juandaniel1.pythonanywhere.com/api/carrito/${widget.cart.carritoId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // El carrito se eliminó exitosamente
        print('Carrito eliminado exitosamente');
      } else {
        // La eliminación del carrito falló
        print('Error al eliminar el carrito. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de conexión u otros errores
      print('Error al eliminar el carrito: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(100),
          height: getProportionateScreenWidth(80),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.cart.carritoImagen!),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cart.carritoNombre!,
              style: TextStyle(color: Colors.black, fontSize: getProportionateScreenWidth(14)),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${widget.cart.carritoPrecioUnitario}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor, fontSize: getProportionateScreenWidth(14)),
                children: [
                  TextSpan(
                      text: " x${widget.cart.carritoCantidad}",
                      style: TextStyle(fontSize: getProportionateScreenWidth(12))),
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),child: Text("SubTotal", style: TextStyle(fontSize: getProportionateScreenWidth(14)),),),

            Text("\$${widget.cart.carritoSubtotal}", style: TextStyle(fontSize: getProportionateScreenWidth(16), fontWeight: FontWeight.bold),),

            IconButton(onPressed: (){deleteCarrito(); Navigator.pushReplacementNamed(context, CartScreen.routeName); Navigator.pushReplacementNamed(context, CartScreen.routeName);}, icon: Icon(Icons.delete)),
          ],
        )
      ],
    );
  }

}
