

import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../models/producto_model.dart';
import '../../../services/api_producto.dart';
import '../../../size_config.dart';
import 'section_title.dart';

// Todos los productos que hay

class PopularProducts extends StatelessWidget {
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      key: UniqueKey(),
      child: loadProductos(),
    );
  }
  Widget loadProductos() {
    return FutureBuilder(
      future: APIProducto.getProductos(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<ProductoModel>?> model,
          ) {
        if (model.hasData) {
          return productoList(model.data, context);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  Widget productoList(productos, BuildContext context) {
    int crossAxisCount = 2; // Valor predeterminado para pantallas más pequeñas

// Obtén el ancho de la pantalla utilizando MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

// Comprueba si el ancho de la pantalla es lo suficientemente grande para aumentar el crossAxisCount
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      crossAxisCount = 3; // Cambia el crossAxisCount para pantallas más grandes
    } else if (screenWidth >= 1000) {
      crossAxisCount = 4;
    }
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 15),
          child: SectionTitle(title: "Productos", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Cambia esto según tus necesidades
                  childAspectRatio: 0.7, // Ajusta el aspect ratio de las tarjetas
                ),
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return ProductCard(model: productos[index]);

                },
              ),
              SizedBox(height: 20),
            ],
          ),
        )

      ],
    );
  }

}
