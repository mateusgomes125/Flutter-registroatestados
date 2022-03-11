import 'package:flutter/material.dart';
import 'package:registroatestados/widgets/auth_check.dart';

class PrimeiraTela extends StatelessWidget {
  const PrimeiraTela({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Atestados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        ),
        home: AuthCheck(),
    );
  }
}