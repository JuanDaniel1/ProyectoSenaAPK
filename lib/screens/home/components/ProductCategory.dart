import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../../components/product_card.dart';
import '../../../config.dart';
import '../../../models/producto_model.dart';
import '../../../size_config.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key, this.id, this.title});
  final id;
  final title;

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  static var client = http.Client();

  Future<List<ProductoModel>?> getProductos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
      "https://juandaniel1.pythonanywhere.com/api/productos/?categoria_id=${widget.id}"
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(productosFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

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
      future: getProductos(),
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
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 10),
              child: SectionTitle(title: widget.title, press: () {}),
            ),
            SizedBox(height: 15),
            Column(
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


          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home,),
    );
      
  }
}
