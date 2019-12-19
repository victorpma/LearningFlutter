import 'dart:io';
import 'package:flutter/material.dart';
import 'contato_page.dart';
import 'package:agenda_contatos/domain/helpers/contato_helper.dart';
import 'package:agenda_contatos/domain/models/contato.dart';

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

    _obterTodosContatos();
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
        onPressed: () {
          _showContatoPage();
        },
      ),
    );
  }

  Widget _contatoCard(context, index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contatos[index].avatar != null
                            ? FileImage(File(contatos[index].avatar))
                            : AssetImage("images/avatar.png"))),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(contatos[index].nome ?? "-",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  Text(
                    contatos[index].email ?? "-",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showContatoPage(contato: contatos[index]);
      },
    );
  }

  void _showContatoPage({Contato contato}) async {
    var recContato = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContatoPage(contato: contato)));

    if (recContato != null) {
      if (contato != null)
        await contatoHelper.atualizarContato(recContato);
      else
        await contatoHelper.inserirContato(recContato);
    }

    _obterTodosContatos();
  }

  void _obterTodosContatos() {
    contatoHelper.obterContatos().then((listContatos) {
      setState(() {
        contatos = listContatos;
      });
    });
  }
}