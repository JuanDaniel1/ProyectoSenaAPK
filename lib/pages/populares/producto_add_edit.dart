import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shop_app/models/categoria_model.dart';
import 'package:shop_app/models/popular_model.dart';
import 'package:shop_app/models/producto_model.dart';
import 'package:shop_app/pages/producto/producto_list.dart';
import 'package:shop_app/services/api_categoria.dart';
import 'package:shop_app/services/api_popular.dart';
import 'package:shop_app/services/api_producto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class PopularAddEdit extends StatefulWidget {
  static String routeName = "/crud";

  PopularAddEdit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularAddEditState createState() => _PopularAddEditState();
}

class _PopularAddEditState extends State<PopularAddEdit> {
  List<CategoriaModel>category = [];
  PopularModel? popular;
  ProductoModel? productoModel;
  CategoriaModel? categoriaModel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Producto'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: loadProductos()
        ),
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
          return Form(key: globalFormKey, child: productoForm(model.data),);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    productoModel = ProductoModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        productoModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productoForm(category) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            width: 300,
            decoration: const BoxDecoration(boxShadow: []),
            child: MultiSelectDialogField(
              buttonText: Text('Categorias'
              ),

              searchable: true,
              confirmText: Text("Ok",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 30),),
              cancelText: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 30),),
              items: category
                  .map((e) => MultiSelectItem(e.id, e.categoriaName!))
                  .toList().cast<MultiSelectItem<dynamic>>(),
              initialValue: productoModel!.selected!,
              onConfirm: (values) {
                setState(() {
                  productoModel!.selected = values.cast();
                });
              },
              title: Text('Categories'),
            ),

          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "ProductoName",
              "Producto Name",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre del producto no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                productoModel!.productoName = onSavedVal,
              },
              initialValue: productoModel!.productoName ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "ProductoDescription",
              "Producto Description",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'La descripcion no puede ser vacio o null ';
                }

                return null;
              },
                  (onSavedVal) => {
                //productModel!.productoPrice = int.parse(onSavedVal),
                productoModel!.productoDescription = onSavedVal,
              },
              initialValue: productoModel!.productoDescription ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.description),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "ProductoPrice",
              "Producto Price",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El precio no puede ser vacio o null ';
                }
                if (double.tryParse(onValidateVal) == null) {
                  return 'Insertar un numero valido con dos decimales ';
                }

                return null;
              },
                  (onSavedVal) => {
                //productModel!.productoPrice = int.parse(onSavedVal),
                productoModel!.productoPrice = onSavedVal,
              },
              initialValue: productoModel!.productoPrice == null
                  ? ""
                  : productoModel!.productoPrice.toString(),
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.monetization_on),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "ProductoCantidad",
              "Producto Cantidad",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'La cantidad no puede ser vacio o null ';
                }

                return null;
              },
                  (onSavedVal) => {
                //productModel!.productoPrice = int.parse(onSavedVal),
                productoModel!.productoCantidad = onSavedVal,
              },
              initialValue: productoModel!.productoCantidad == null
                  ? ""
                  : productoModel!.productoCantidad.toString(),
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.description),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "ProductoURL",
              "Producto URL",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'URL no puede ser vacio o null ';
                }

                return null;
              },
                  (onSavedVal) => {
                //productModel!.productoPrice = int.parse(onSavedVal),
                productoModel!.productoImage = onSavedVal,
              },
              initialValue: productoModel!.productoImage ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.description),
            ),
          ),


          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
                  () {
                if (validateAndSave()) {
                  print(productoModel!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIProducto.saveProducto(
                    productoModel!,
                    isEditMode,
                    isImageSelected,
                  ).then(
                        (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ProductosList.routeName,
                              (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Error occur",
                          "OK",
                              () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  static Widget picPicker(
      bool isImageSelected,
      String fileName,
      Function onFilePicked,
      ) {
    Future<XFile?> imageFile;
    ImagePicker picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isImageSelected
            ? Image.network(
          fileName,
          width: 300,
          height: 300,
        )
            : SizedBox(
          child: Image.network(
            fileName,
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
        )
            : SizedBox(
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image, size: 35.0),
                onPressed: () {
                  imageFile = picker.pickImage(source: ImageSource.gallery);
                  imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: const Icon(Icons.camera, size: 35.0),
                onPressed: () {
                  imageFile = picker.pickImage(source: ImageSource.camera);
                  imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

}