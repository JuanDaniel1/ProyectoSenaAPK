import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/MySplashPage.dart';
import 'package:shop_app/screens/cart/provider.dart';
import 'package:shop_app/screens/faceauth/locator.dart';
import 'package:shop_app/screens/faceauth/services/camera.service.dart';
import 'package:shop_app/screens/faceauth/services/face_detector_service.dart';
import 'package:shop_app/screens/faceauth/services/ml_service.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

Future main() async{
  setupServices();
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCYOpzbtNJgTw8wDiW9R1h7q9LmekvGORo", appId: "1:473814828693:web:31c54959d45b72b6b8bd9c", messagingSenderId: "473814828693", projectId: "precise-airship-402104"));
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MLService _mlService = locator<MLService>();
  FaceDetectorService _mlKitService = locator<FaceDetectorService>();
  CameraService _cameraService = locator<CameraService>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    setState(() => loading = true);
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
    setState(() => loading = false);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
    ChangeNotifierProvider(create: (_) => new ShoppingCartProvider())
    ],
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: MySplash.routeName,
      routes: routes,
    )
    );
  }
}
