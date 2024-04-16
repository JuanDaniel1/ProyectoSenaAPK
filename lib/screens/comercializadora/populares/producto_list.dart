import 'package:flutter/material.dart';
import 'package:shop_app/pages/populares/producto_item.dart';
import 'package:shop_app/pages/producto/producto_add_edit.dart';
import 'package:shop_app/pages/producto/producto_item.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'package:shop_app/models/popular_model.dart';
import 'package:shop_app/services/api_popular.dart';

class PopularListComerc extends StatefulWidget {
  static String routeName="/Popular-listComerc";
  const PopularListComerc({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularListComercState createState() => _PopularListComercState();
}

class _PopularListComercState extends State<PopularListComerc> {
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
      future: APIPopular.getProductos(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<PopularModel>?> model,
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
                  return PopularItem(
                    model: productos[index],
                    onDelete: (PopularModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIPopular.deleteProducto(model.id).then(
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