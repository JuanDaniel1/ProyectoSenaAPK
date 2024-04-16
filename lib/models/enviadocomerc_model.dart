import 'dart:convert';


List<EnviadoComercModel> enviadocomercFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<EnviadoComercModel>((json) => EnviadoComercModel.fromJson(json))
      .toList();
}

class EnviadoComercModel {
  late int? id;
  late String? nombre;
  late String? enviado;

  EnviadoComercModel({
    this.id,
    this.nombre,
    this.enviado,

  });

  factory EnviadoComercModel.fromJson(Map<String, dynamic> json) {
    return EnviadoComercModel(
      id: json['id'] as int,
      nombre: json['nombre'],
      enviado: json['enviado'],


    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['enviado'] = enviado;
    return data;
  }
}