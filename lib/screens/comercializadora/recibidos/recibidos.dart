import 'package:flutter/material.dart';
import 'package:shop_app/menucomerc.dart';
import 'package:shop_app/services/api_enviadoscomerc.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:http/http.dart' as http;
import '../../../menuAdmin.dart';
import '../../../models/enviado_model.dart';
import '../../../models/enviadocomerc_model.dart';
import '../../../services/api_enviados.dart';

class Recibidos extends StatefulWidget {
  const Recibidos({super.key});

  @override
  State<Recibidos> createState() => _RecibidosState();
}

class _RecibidosState extends State<Recibidos> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController shippedController = TextEditingController();
  final TextEditingController receivedController = TextEditingController();
  final TextEditingController lootController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      key: UniqueKey(),
      child: loadProductos(),
    );
  }

  Widget loadProductos() {
    return FutureBuilder(
      future: APIenviadoComerc.getenviados(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<EnviadoComercModel>?> model,
          ) {
        if (model.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (model.hasError) {
          return Center(
            child: Text('Error: ${model.error}'),
          );
        } else if (model.hasData) {
          return productoList(model.data!, context);
        } else {
          return const Text('No se encontraron datos');
        }

      },
    );
  }
  Widget productoList(recibidos, BuildContext context){
    return ListView.builder(itemCount: recibidos.length, itemBuilder: (context, index){
          TextEditingController textFieldController = TextEditingController();
          Future<void> eliminarElemento(int index) async {
            final id = recibidos[index].id; // Suponiendo que cada elemento tenga un campo 'id'

            final response = await http.delete(Uri.parse('https://juandaniel1.pythonanywhere.com/api/envioscomerc/$id'));

            if (response.statusCode == 200) {
              setState(() {
                recibidos.removeAt(index); // Eliminar el elemento de la lista local
              });
            } else {
              // Manejar errores
            }
          }
          Future<void> postData() async {
            final url = "https://juandaniel1.pythonanywhere.com/api/envios/"; // Reemplaza esto con la URL de tu API
            final response = await http.post(
              Uri.parse(url),
              body: {
                'nombre': recibidos[index].nombre,
                'enviado': recibidos[index].enviado,
                'recibido': textFieldController.text,
              },
            );
            if (response.statusCode == 200 || response.statusCode == 201) {
              // Si la solicitud fue exitosa
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Datos enviados con éxito'),
                  duration: Duration(seconds: 2),
                ),
              );
              // Limpiar los campos de texto
              productNameController.clear();
              shippedController.clear();
              receivedController.clear();
              lootController.clear();
            } else {
              // Si hubo un error en la solicitud
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error al enviar datos'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
          return ListTile(
              title: Text(recibidos[index].nombre),
              subtitle: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(right: 30),child: Text('ID: ${recibidos[index].id}'),),
                      Padding(padding: EdgeInsets.only(right: 30),child: Text('Enviados: ${recibidos[index].enviado}'),)







                    ],
                  ),
                  Expanded(child: TextField(

                    // Aquí puedes manejar la entrada de texto como desees
                    controller: textFieldController,
                    decoration: InputDecoration(
                      hintText: "Recibidos"
                    ),
                  ),),

                  IconButton(onPressed: (){
                    postData();
                    eliminarElemento(index);
                    Navigator.pushReplacementNamed(context, MenuComerc.routeName);
                  }, icon: Icon(Icons.send, color: Colors.green,))
                ],
              )

          );
        },);


  }
}
