import 'package:flutter/material.dart';
import 'package:shop_app/models/categoria_model.dart';
import 'package:shop_app/pages/categoria/categoria_add_edit.dart';
import 'package:shop_app/pages/categoria/categoria_item.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/services/api_categoria.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../menu.dart';

class CategoriasList extends StatefulWidget {
  static String routeName="/Category-list";
  const CategoriasList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriasListState createState() => _CategoriasListState();
}

class _CategoriasListState extends State<CategoriasList> {
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
        child: loadcategorias(),
      ),
    );
  }

  Widget loadcategorias() {
    return FutureBuilder(
      future: APIcategoria.getcategorias(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<CategoriaModel>?> model,
          ) {
        if (model.hasData) {
          return categoriaList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }


  Widget categoriaList(categorias) {
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
                          CategoriaAddEdit.routeName,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Add categoria',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          MenuTutor.routeName,
                        );
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Menu',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          HomeScreen.routeName,
                        );
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Home',
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
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  return CategoriaItem(
                    model: categorias[index],
                    onDelete: (CategoriaModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIcategoria.deletecategoria(model.id).then(
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