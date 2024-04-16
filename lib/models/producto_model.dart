import 'dart:convert';

List<ProductoModel> productosFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ProductoModel>((json) => ProductoModel.fromJson(json))
      .toList();
}

class ProductoModel {
  late int? id;
  late String? productoName;
  late String? productoDescription;
  late String? productoPrice;
  late String? productoImage;
  late String? productoCantidad;
  late String? subtotal;
  late String? counter;
  late List<dynamic?>selected=[];
  double total = 0.0;

  ProductoModel({
    this.id,
    this.productoName,
    this.productoDescription,
    this.productoPrice,
    this.productoImage,
    this.productoCantidad,
    this.subtotal,
    this.counter
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'] as int,
      productoName: json['productoName'] as String,
      productoDescription: json['productoDescription'],
      productoPrice: json['productoPrice'],
      productoImage: json['productoImage'],
      productoCantidad: json['productoCantidad']
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productoName'] = productoName;
    data['productoDescription'] = productoDescription;
    data['productoPrice'] = productoPrice;
    data['productoImage'] = productoImage;
    data['productoCantidad'] = productoCantidad;
    return data;
  }
}