import 'dart:convert';


List<CategoriaModel> categoriasFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<CategoriaModel>((json) => CategoriaModel.fromJson(json))
      .toList();
}

class CategoriaModel {
  late int? id;
  late String? categoriaName;
  late String? categoriaImage;

  CategoriaModel({
    this.id,
    this.categoriaName,
    this.categoriaImage,

  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
        id: json['id'] as int,
        categoriaName: json['nombre'],
        categoriaImage: json['imagen'],


    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = categoriaName;
    data['imagen'] = categoriaImage;
    return data;
  }
}