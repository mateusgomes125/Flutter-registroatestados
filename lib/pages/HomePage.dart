import 'package:flutter/material.dart';
import 'package:registroatestados/pages/formatestados.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atesdados'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => FormAtestados(),
                      ),
                    );
            },
            
          )
        ],
      ),
      // body: ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     return;
      //   },
      // ),
    );
  }
}
