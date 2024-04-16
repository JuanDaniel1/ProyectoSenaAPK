import 'package:flutter/foundation.dart';
import 'package:shop_app/models/enviado_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIenviado {
  static var client = http.Client();

  static Future<List<EnviadoModel>?> getenviados() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.enviadosAPI}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(enviadoFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveenviado(
      EnviadoModel model,
      bool isEditMode,
      bool isFileSelected,
      ) async {
    var productURL = "${Config.enviadosAPI}/";

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
    request.fields["nombre"] = model.nombre!;
    //request.headers["Authorization"] = "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4";
    request.fields["enviado"] = model.enviado!.toString();
    request.fields["recibido"] = model.recibido!;


    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteenviado(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiURL}${Config.enviadosAPI}/$productId/");

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