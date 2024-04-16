class Producto {
  final String productoName;
  final String  productoCategoria;
  final String productoCantidad;
  final String productoPrice;
  final String productoImage;


  Producto({required this.productoName, required this.productoCategoria, required this.productoCantidad, required this.productoPrice, required this.productoImage,});

  static Producto fromJson(Map json){
    return Producto(
      productoName     : json['productoName'],
      productoCategoria: json['productoCategoria'],
      productoPrice    : json['productoPrice'],
      productoCantidad : json['productoCantidad'],
      productoImage    : json['productoImage'],
    );
  }
}