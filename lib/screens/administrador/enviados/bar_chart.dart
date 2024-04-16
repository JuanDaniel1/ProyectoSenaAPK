

import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/menuAdmin.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/api_enviados.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import '../../../models/enviado_model.dart';
import '../../../models/producto_model.dart';
import '../../../services/api_producto.dart';
import '../../../size_config.dart';

// Todos los productos que hay

class GraficaEnvio extends StatefulWidget {
  const GraficaEnvio({super.key});

  @override
  State<GraficaEnvio> createState() => _GraficaEnvioState();
}

class _GraficaEnvioState extends State<GraficaEnvio> {
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
      future: APIenviado.getenviados(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<EnviadoModel>?> model,
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


  Widget productoList(enviados, BuildContext context) {
   return
     Column(children: [
       //Initialize the chart widget
       SfCartesianChart(
           primaryXAxis: CategoryAxis(),
           // Chart title
           title: ChartTitle(text: 'Productos enviados y recibidos'),
           // Enable legend
           legend: Legend(isVisible: true),
           // Enable tooltip
           tooltipBehavior: TooltipBehavior(enable: true),
           series: <CartesianSeries<EnviadoModel, String>>[
             LineSeries<EnviadoModel, String>(
                 dataSource: enviados,
                 xValueMapper: (EnviadoModel sales, _) => sales.nombre,
                 yValueMapper: (EnviadoModel sales, _) =>int.parse(sales.enviado!) ,
                 name: 'Enviados',
                 // Enable data label
                 dataLabelSettings: DataLabelSettings(isVisible: true)),
             LineSeries<EnviadoModel, String>(
                 dataSource: enviados,
                 xValueMapper: (EnviadoModel sales, _) => sales.nombre,
                 yValueMapper: (EnviadoModel sales, _) =>int.parse(sales.recibido!) ,
                 color: Colors.orange,
                 name: 'Recibidos',
                 // Enable data label
                 dataLabelSettings: DataLabelSettings(isVisible: true)),
             LineSeries<EnviadoModel, String>(
                 dataSource: enviados,
                 xValueMapper: (EnviadoModel sales, _) => sales.nombre,
                 yValueMapper: (EnviadoModel sales, _) =>int.parse(sales.enviado!) - int.parse(sales.recibido!) ,
                 color: Colors.red,
                 name: 'Perdidas',
                 // Enable data label
                 dataLabelSettings: DataLabelSettings(isVisible: true)),
           ]),
       Expanded(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           //Initialize the spark charts widget
           child: ListView.builder(itemCount: enviados.length, itemBuilder: (context, index){
             Future<void> eliminarElemento(int index) async {
               final id = enviados[index].id; // Suponiendo que cada elemento tenga un campo 'id'

               final response = await http.delete(Uri.parse('https://juandaniel1.pythonanywhere.com/api/envios/$id'));

               if (response.statusCode == 200) {
                 setState(() {
                   enviados.removeAt(index); // Eliminar el elemento de la lista local
                 });
               } else {
                 // Manejar errores
               }
             }
             return ListTile(
               title: Text(enviados[index].nombre),
               subtitle: Row(
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('ID: ${enviados[index].id}'),
                       Text('Enviados: ${enviados[index].enviado}'),
                       Text('Recibidos: ${enviados[index].recibido}'),
                     ],
                   ),
                   IconButton(onPressed: (){
                     eliminarElemento(index);
                     Navigator.pushReplacementNamed(context, MenuAdmin.routeName);
                   }, icon: Icon(Icons.delete, color: Colors.red,))
                 ],
               )

             );
           },)
         ),
       )
     ]);
  }
}
