import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../models/popular_model.dart';
import '../models/producto_model.dart';

class APIPopular {
  static var client = http.Client();

  static Future<List<PopularModel>?> getProductos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.popularAPI}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(popularFromJson, response.body);

      //return true;
    } else {
    }
  }

  static Future<bool> saveProducto(
      ProductoModel model,
      ) async {
    var productURL = "${Config.popularAPI}/";



    var url = Uri.parse("${Config.apiURL}$productURL");


    /*Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4",
    };*/

    var request = http.MultipartRequest("POST", url);
    request.fields["productoName"] = model.productoName!;
    request.fields["productoPrice"] =
        double.parse(model.productoPrice!).toString();
    //request.headers["Authorization"] = "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4";
    request.fields["productoImage"] = model.productoImage!;

    var response = await request.send();

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

    var url = Uri.parse("${Config.apiURL}${Config.popularAPI}/$productId/");

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