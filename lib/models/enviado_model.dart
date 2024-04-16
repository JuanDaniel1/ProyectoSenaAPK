import 'dart:convert';


List<EnviadoModel> enviadoFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<EnviadoModel>((json) => EnviadoModel.fromJson(json))
      .toList();
}

class EnviadoModel {
  late int? id;
  late String? nombre;
  late String? enviado;
  late String? recibido;

  EnviadoModel({
    this.id,
    this.nombre,
    this.enviado,
    this.recibido

  });

  factory EnviadoModel.fromJson(Map<String, dynamic> json) {
    return EnviadoModel(
      id: json['id'] as int,
      nombre: json['nombre'],
      enviado: json['enviado'],
      recibido: json['recibido'],


    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['enviado'] = enviado;
    data['recibido'] = recibido;
    return data;
  }
}