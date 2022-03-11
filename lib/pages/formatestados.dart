import 'dart:html';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registroatestados/pages/previewpage.dart';
import 'package:registroatestados/widgets/anexo.dart';

class FormAtestados extends StatefulWidget {
  @override
  State<FormAtestados> createState() => _FormAtestadosState();
}

class _FormAtestadosState extends State<FormAtestados> {
  final TextEditingController _controladorNomePaciente =
      TextEditingController();
  final TextEditingController _controladorNomeMedico = TextEditingController();
  final TextEditingController _controladorData = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();

  late File arquivo;
  final picker = ImagePicker();
  final _FormKey = GlobalKey<FormState>();

  showPreview(file) async {
    file = await Get.to(() => PreviewPage(file: file));

    if (file != null) {
      setState(() => arquivo = file);
      Get.back();
    }
  }

  Future getFileFromGallery() async {
    final file = await picker.getImage(source: ImageSource.gallery);

    if(file != null) {
      setState(() => arquivo = File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Text('Cadastra de atestado'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                bool isValid = _FormKey.currentState!.validate();

                if (isValid) {
                  _FormKey.currentState!.save();

                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
        body: Form(
          key: _FormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              TextFormField(
                controller: _controladorNomePaciente,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome do Paciente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome Vazio. Digite um nome.';
                  }

                  if (value.trim().length <= 31) {
                    return 'tamanho mínimo de 3 caracteres';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controladorNomeMedico,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nome do Médico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome Vazio. Digite um nome.';
                  }

                  if (value.trim().length <= 31) {
                    return 'tamanho mínimo de 3 caracteres';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controladorData,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data da consulta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data Vazia. Informe a data da consulta.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controladorDescricao,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição',
                ),
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  if (arquivo != null) Anexo(arquivo: arquivo),
                  ElevatedButton.icon(
                    onPressed: () => Get.to(
                      () => CameraCamera(onFile: (file) => showPreview(file)),
                    ),
                    icon: Icon(Icons.camera_alt),
                    label: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Tire uma foto do atestado'),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      textStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('ou'),
                  ),
                  OutlinedButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('Selecione um arquivo'),
                    onPressed: () => getFileFromGallery(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
