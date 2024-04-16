import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/producto_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIProducto {
  static var client = http.Client();

  static Future<List<ProductoModel>?> getProductos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.productosAPI}");

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

  static Future<bool> saveProducto(
      ProductoModel model,
      bool isEditMode,
      bool isFileSelected,
      ) async {
    var productURL = "${Config.productosAPI}/";

    if (isEditMode) {
      productURL = "$productURL${model.id.toString()}/";
    }

    var url = Uri.parse("${Config.apiURL}$productURL");

    var requestMethod = isEditMode ? "PUT" : "POST";

    /*Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4",
    };*/

    var request = http.Request(requestMethod, url);
    request.headers["Content-Type"] = "application/json";
    var requestBody = {
      "productoName": model.productoName!,
      "productoDescription": model.productoDescription!,
      "productoPrice": double.parse(model.productoPrice!).toString(),
      "productoImage": model.productoImage!,
      "productoCantidad": model.productoCantidad!.toString(),
      "productoCategoria": model.selected,
    };
    // Convert the request body to JSON and set it in the request
    request.body = jsonEncode(requestBody);

    var response = await http.Client().send(request);


    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProducto(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.productosAPI}/$productId/");

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