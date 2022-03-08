import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registroatestados/models/user.dart';

class Cadastro extends StatelessWidget {
  Cadastro({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              bool isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                // Provider.of(context)
                //     .put(User(
                //     id: _formData['id'], 
                //     name: _formData['Nome'], 
                //     email: _formData['E-mail'], 
                //     senha: _formData['Senha']
                //     ));

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome Vazio. Digite um nome.';
                  }

                  if (value.trim().length <= 31) {
                    return 'tamanho mínimo de 3 caracteres';
                  }

                  return null;
                },
                //onSaved: (value) => _formData['Nome'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                //onSaved: (value) => _formData['E-mail'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                //onSaved: (value) => _formData['Senha'] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
