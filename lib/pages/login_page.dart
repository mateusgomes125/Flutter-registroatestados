//import 'dart:html';
import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:registroatestados/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:registroatestados/pages/HomePage.dart';

//import 'package:registroatestados/pages/cadastro.dart';
//import 'package:registroatestados/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;

      if (isLogin) {
        titulo = 'Bem-vindo';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao login';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe o email corretamente";
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: TextFormField(
                      controller: email,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe sua senha";
                        } else if (value.length < 6) {
                          return "A senha deve conter no mínimo 6 caracteres";
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          setState(() => loading = true);
                          try {
                            context
                                .read<AuthService>()
                                .Registrar(email.text, senha.text);
                                
                                Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomePage(),
                                ),
                              );
                          } on AuthException catch (e) {
                            setState(() => loading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));                            
                          }
                        } else {
                          setState(() => loading = true);
                          try {
                            context
                                .read<AuthService>()
                                .Login(email.text, senha.text);

                            Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomePage(),
                                ),
                              );
                          } on AuthException catch (e) {
                            setState(() => loading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading) 
                      ? [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            width: 24, 
                            height: 24, 
                            child: CircularProgressIndicator(color: Colors.white)
                          ),
                        )
                      ]
                      :
                      [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            actionButton,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggleButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
