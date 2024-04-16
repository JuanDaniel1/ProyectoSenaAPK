import 'dart:convert';

List<PopularModel> popularFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<PopularModel>((json) => PopularModel.fromJson(json))
      .toList();
}

class PopularModel {
  late int? id;
  late String? productoName;
  late String? productoPrice;
  late String? productoImage;
  late String? productoDescription;
  late String? productoCantidad;
  double total = 0.0;



  PopularModel({
    this.id,
    this.productoName,
    this.productoPrice,
    this.productoImage,
    this.productoDescription,
    this.productoCantidad
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) {
    return PopularModel(
        id: json['id'] as int,
        productoName: json['productoName'],
        productoPrice: json['productoPrice'],
        productoImage: json['productoImagen'],
        productoCantidad: json['productoCantidad'],
        productoDescription: json['productoDescription']
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productoName'] = productoName;
    data['productoPrice'] = productoPrice;
    data['productoImagen'] = productoImage;
    data['productoDescription'] = productoDescription;
    data['productoCantidad'] = productoCantidad;
    return data;
  }
}