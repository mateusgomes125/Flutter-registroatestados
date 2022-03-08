import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/src/fa_icon.dart';
import 'package:provider/provider.dart';
import 'package:registroatestados/pages/cadastro.dart';
import 'package:registroatestados/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String senha = '';

  late bool _obscurePass;

  @override
  void initState() {
    super.initState();
    _obscurePass = true;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Material(
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder())),
              SizedBox(height: 10),
              TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: _obscurePass
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      iconSize: 30,
                      onPressed: () =>
                          setState(() => _obscurePass = !_obscurePass),
                    ),
                  )),
              SizedBox(height: 20),
              Container(
                width: width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Entrar'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  'Não possui uma conta? Cadastre-se',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => Cadastro(),
                      ),
                    );
                  },
                  child: Text('Cadastre-se'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: loginUI(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginUI() {
    return Consumer<GoogleSignInController>(
      builder: (context, model, child) {
        if (model.googleAccount != null) {
          return Center(
            child: loggedInUI(model),
          );
        } else {
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(GoogleSignInController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.googleAccount!.photoUrl ?? '').image,
          radius: 50,
        ),
        Text(model.googleAccount!.displayName ?? ''),
        Text(model.googleAccount!.email),
        ActionChip(
          avatar: Icon(Icons.logout),
          label: Text('Logout'),
          onPressed: () {
            Provider.of<GoogleSignInController>(context, listen: false)
                .logOut();
          },
        )
      ],
    );
  }

  loginControls(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            child: Image.asset(
              "assets/images/google.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<GoogleSignInController>(context, listen: false)
                  .login();
            },
          )
        ],
      ),
    );
  }
}
