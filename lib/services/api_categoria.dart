import 'package:flutter/foundation.dart';
import 'package:shop_app/models/categoria_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIcategoria {
  static var client = http.Client();

  static Future<List<CategoriaModel>?> getcategorias() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.categoriasAPI}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(categoriasFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> savecategoria(
      CategoriaModel model,
      bool isEditMode,
      bool isFileSelected,
      ) async {
    var productURL = "${Config.categoriasAPI}/";

    if (isEditMode) {
      productURL = "$productURL${model.id.toString()}/";
    }

    var url = Uri.parse("${Config.apiURL}$productURL");

    var requestMethod = isEditMode ? "PUT" : "POST";

    /*Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4",
    };*/

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = model.categoriaName!;
    //request.headers["Authorization"] = "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4";
    request.fields["imagen"] = model.categoriaImage!;


    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletecategoria(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.categoriasAPI}/$productId/");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}