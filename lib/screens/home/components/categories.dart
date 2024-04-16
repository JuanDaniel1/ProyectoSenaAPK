import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/home/components/ProductCategory.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/services/api_categoria.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../models/categoria_model.dart';
import '../../../size_config.dart';

// Seccion de categorias

class Categories extends StatelessWidget {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {

    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      key: UniqueKey(),
      child: loadCategorias(),
    );
  }
  Widget loadCategorias() {
    return FutureBuilder(
      future: APIcategoria.getcategorias(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<CategoriaModel>?> model,
          ) {
        if (model.hasData) {
          return categoriaList(model.data, context);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  Widget categoriaList(categorias, BuildContext context) {
    double size = 75;
    double fosize = 20;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      size = 95; // Cambia el crossAxisCount para pantallas más grandes
      fosize = 25;
    } else if (screenWidth >= 1000) {
      size = 115;
      fosize = 30;
    }
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 15),
          child: SectionTitle(
            title: "Categorias",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categorias.length,
                    (index) => categorias[index] != null
                        ? CategoryCard(
                      model: categorias[index],
                      press: () {
                        // Acciones cuando se presiona la tarjeta de categoría
                      },
                    )
                        : Container(),
              ),
            ),
          ),
        )

      ],
    );
  }
}
class CategoryCard extends StatefulWidget {

  const CategoryCard({super.key,
    required this.press, this.model,});
  final CategoriaModel? model;
  final GestureTapCallback press;


  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late bool borde = false;
  @override
  Widget build(BuildContext context) {
    double size = 75;
    double fosize = 20;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      size = 95; // Cambia el crossAxisCount para pantallas más grandes
      fosize = 25;
    } else if (screenWidth >= 1000) {
      size = 115;
      fosize = 30;
    }

    return Padding(padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
          onTap: (){
            setState(() {
              borde = !borde;
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProductCategory(id: widget.model!.id!, title: widget.model!.categoriaName!,)));
            });
          },

            child: Column(
              children: [
              Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${widget.model!.categoriaImage!}"),
                ),
              ),
            ),

                 Text(
                      widget.model!.categoriaName!,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: fosize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),


              ],
            ),


      ),);

  }
}


