import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registroatestados/pages/PrimeiraTela.dart';
import 'package:registroatestados/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:registroatestados/pages/HomePage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await Firebase.initializeApp(
  //   // Replace with actual values
  //   options: FirebaseOptions(
  //     apiKey: "AIzaSyCABVFXCQyhpdjO1W34qF_oLY7eFK1x0mM",
  //     appId: "1:269486832252:android:43ec03f154098e065be7f9",
  //     messagingSenderId: "269486832252",
  //     projectId: "registroatestados",
  //   ),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MultiProvider(
              providers: [
              ChangeNotifierProvider(
                 create: (context) => AuthService()
               ),

              ],
              child: MaterialApp(
                home: PrimeiraTela(),
                debugShowCheckedModeBanner: false,
                ),
            );
}
