import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registroatestados/google_sign_in.dart';
//import 'package:registroatestados/google_sign_in.dart';
import 'package:registroatestados/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       // ChangeNotifierProvider(
       //   create: (context) => AuthService()
      //  ),
        ChangeNotifierProvider(
          create: (context) => GoogleSignInController(),
          child: LoginPage(),
        ), 
        
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
