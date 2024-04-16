class Receta {
  final int id;
  final String name;
  final String image;
  final String descripcion;

  const Receta({
    required this.id,
    required this.name,
    required this.image,
    required this.descripcion
  });

  factory Receta.fromJson(Map<String,dynamic> json)=> Receta(
      id: json["id"],
      name: json["name"],
      image:json["image"],
      descripcion: json["descripcion"]
  );

  Map<String,dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "image" : image,
    "descripcion" : descripcion,
  };
  Receta copy() => Receta(
      id: id,
      name: name,
      image: image,
      descripcion: descripcion
  );
}