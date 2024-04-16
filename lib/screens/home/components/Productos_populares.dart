import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/config.dart';

import '../../../models/popular_model.dart';
import '../../../models/producto_model.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';
import '../../detailspopular/details_screen.dart';
import 'section_title.dart';
import 'package:http/http.dart' as http;

// Seccion de productos populares

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  Future<List<PopularModel>> fetchPopularData() async {
    final response = await http.get(Uri.parse("${Config.apiURL}${Config.popularAPI}"));

    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON y mapear a instancias de PopularModel
      List<PopularModel> popularList = popularFromJson(response.body);
      return popularList;
    } else {
      // Si la solicitud no fue exitosa, lanzar una excepción o manejar el error según sea necesario
      throw Exception('Error al cargar datos desde la API');
    }
  }
  void main() async {
    try {
      List<PopularModel> popularData = await fetchPopularData();
      // Hacer algo con los datos obtenidos, por ejemplo, imprimirlos
      print(popularData);
    } catch (e) {
      // Manejar el error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularModel>>(
      future: fetchPopularData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se espera la respuesta.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron datos');
        } else {
          // Construir dinámicamente la lista de SpecialOfferCard
          List<SpecialOfferCard> offerCards = snapshot.data!
              .map((popularModel) => SpecialOfferCard(
            image: popularModel.productoImage!,
            category: popularModel.productoName!,
            numOfBrands: int.parse(popularModel.productoPrice!),

            press: () {
              // Acción al hacer clic en la tarjeta (puedes dejarlo vacío o agregar acciones según tu necesidad)
            }, description: popularModel.productoDescription!, cantidad: popularModel.productoCantidad!, id: popularModel.id!,
          ))
              .toList();

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10),
                child: SectionTitle(
                  title: "Populares",
                  press: () {},
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...offerCards, // Usar el operador spread para agregar las tarjetas a la lista
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press, this.model, required this.description, required this.cantidad, required this.id
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;
  final String description;
  final PopularModel? model;
  final String cantidad;
  final int id;

  @override
  Widget build(BuildContext context) {
    double fosize = 20;
    double size = 150;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      size = 160; // Cambia el crossAxisCount para pantallas más grandes
      fosize = 25;
    } else if (screenWidth >= 1000) {
      size = 170;
      fosize = 30;
    }
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, DetailsPopularScreen.routeName, arguments: ProductPopularDetailsArguments(image: image, name: category, price: numOfBrands, description: description, cantidad: cantidad, id: id));
        },
        child: SizedBox(
          height: size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,

                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "$category\n",
                              style: TextStyle(
                                fontSize: fosize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "\$$numOfBrands", style: TextStyle(fontSize: fosize))
                          ],
                        ),
                      ),
                    )

                  )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
