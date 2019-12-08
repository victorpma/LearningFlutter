import 'dart:io';

import 'package:agenda_contatos/domain/helpers/contato_helper.dart';
import 'package:agenda_contatos/domain/models/contato.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContatoHelper contatoHelper = ContatoHelper();

  List<Contato> contatos = List();

  @override
  void initState() {
    super.initState();

    contatoHelper.obterContatos().then((listContatos) {
      setState(() {
        contatos = listContatos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Contatos"),
          centerTitle: true,
          backgroundColor: Colors.red),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return _contatoCard(context, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _contatoCard(context, index) {
    return GestureDetector(
      child: Card(        
        child: Row(        
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage("images/avatar.png"))),
            ),
            Column(
              children: <Widget>[Text("Titulo")],
            )
          ],
        ),
      ),
    );
  }
}
