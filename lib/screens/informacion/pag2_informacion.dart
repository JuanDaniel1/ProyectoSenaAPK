import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/screens/informacion/data/data_receta.dart';
import 'package:shop_app/screens/informacion/models/model_receta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shop_app/enums.dart';

class Carousel extends StatefulWidget {
  static String routeName = "/info";
  const Carousel({Key? key}): super (key:key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30,),
          CarouselSlider.builder(
            itemCount: carrouselImages.length,
            itemBuilder: (context, index, realIndex){
              final carruselImage = carrouselImages[index];
              return CardImages(carrouselImages: carruselImage,);
            },
            options: CarouselOptions(
              height: 300.0,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 20,),
          Text("¿Que es el Sena?",
            style: GoogleFonts.oswald(fontWeight: FontWeight.w700, fontSize: 40, color: Colors.black)),
          SizedBox(height: 2,),
          Padding(
            padding: const EdgeInsets.all(35),
            child: Text("Es una estrategia institucional para contribuir en la permanencia y el desempeño exitoso de los aprendices de la entidad en su proceso formativo con enfoque territorial y diferencial.Dirigido a "
                "todos los aprendices matriculados en formación titulada, para todos los niveles, en sus diferentes modalidades: presencial, virtual o a distanciaContribuir al desarrollo humano integral de los aprendices, "
                "por medio de la definición de lineamientos que se implementen de manera articulada y gradual con el proceso de formación profesional integral.",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(fontSize: 17, fontWeight: FontWeight.w300, color: Colors.black54),
            ),
          ),
          SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton( onPressed:(){
                  launch("https://www.facebook.com/SENACundinamarca");
                },icon:Icon(Icons.facebook),iconSize: 40,color: Colors.blue,
                ),
                IconButton( onPressed:(){
                  launch("https://twitter.com/senacomunica?lang=es");
                },icon:Icon(FontAwesomeIcons.twitter),iconSize: 40,color: Colors.blue,
                ),
                IconButton( onPressed:(){
                  launch("https://www.instagram.com/senacundinamarca/?fbclid=IwAR1OsRGrSQIPpPmfa7plVHXtGIFVCT4DobBAyTgW0YDIl9frelaPA2iCI8g");
                },icon:Icon(FontAwesomeIcons.instagram),iconSize: 40,color: Colors.purpleAccent,
                )
              ],
            ),
          )
        ],
      ),
    ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite,),

    );
  }

}




class CardImages extends StatelessWidget {
  final Receta carrouselImages;
  const CardImages({super.key, required this.carrouselImages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: (){},
          child: FadeInImage(placeholder: AssetImage("assets/carrusel/img1.jpg"),
              image: AssetImage(
                  carrouselImages.image
              ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
