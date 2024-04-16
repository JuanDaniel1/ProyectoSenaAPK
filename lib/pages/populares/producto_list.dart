import 'package:flutter/material.dart';
import 'package:shop_app/pages/populares/producto_item.dart';
import 'package:shop_app/pages/producto/producto_add_edit.dart';
import 'package:shop_app/pages/producto/producto_item.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../models/popular_model.dart';
import '../../services/api_popular.dart';

class PopularList extends StatefulWidget {
  static String routeName="/Product-list";
  const PopularList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
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
              Row(
                // ignore: sort_child_properties_last
                children: [

                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          HomeScreen.routeName,
                        );
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Menu',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

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