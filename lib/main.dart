import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apploja/main.dart';
import 'package:apploja/model/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDXsjd_zabC5Llga1CzLxRg7XWdS50C5UU",
          authDomain: "dbflutter-8a65f.firebaseapp.com",
          projectId: "dbflutter-8a65f",
          storageBucket: "dbflutter-8a65f.appspot.com",
          messagingSenderId: "433799420794",
          appId: "1:433799420794:web:a9c7831e3368fe091614c3"));

  //wait dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const primaryColor = Color.fromARGB(255, 198, 84, 189);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Lojas 1.000',
      theme: ThemeData(primaryColor: MyApp.primaryColor),
      initialRoute: '/',
      //Gerador de rotas - navegação entre as telas
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
