import 'package:flutter/material.dart';
import 'package:shop_app/models/producto_model.dart';
import 'package:shop_app/pages/producto/producto_add_edit.dart';
import 'package:shop_app/pages/producto/producto_item.dart';
import 'package:shop_app/screens/comercializadora/producto/producto_item.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/services/api_producto.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'package:shop_app/menu.dart';

class ProductosListComerc extends StatefulWidget {
  static String routeName="/Product-listComerc";
  const ProductosListComerc({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductosListComercState createState() => _ProductosListComercState();
}

class _ProductosListComercState extends State<ProductosListComerc> {
  // List<ProductModel> products = List<ProductModel>.empty(growable: true);
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('Django - CRUD'),
        elevation: 0,
      ),*/
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadProductos(),
      ),
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
          return productoList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productoList(productos) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              //Navigator.pushNamed(context,'/add-product',);
              //Add Product
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return ProductoItemComerc(
                    model: productos[index],
                    onDelete: (ProductoModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIProducto.deleteProducto(model.id).then(
                            (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}