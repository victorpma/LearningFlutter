import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
        _showOpcoesContato(context, index);
      },
    );
  }

  void _showOpcoesContato(BuildContext context, index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text(
                            "Ligar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          onPressed: () {
                            launch("tel: 79991109402");
                            Navigator.pop(context);
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showContatoPage(contato: contatos[index]);
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Deseja realmente excluir contato?"),
                                    content: Text(
                                        "Se confirmar, a exclusão não poderá ser desfeita."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Sim",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          contatoHelper.excluirContato(
                                              contatos[index].id);
                                          _obterTodosContatos();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Não",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        )),
                  ],
                ),
              );
            },
          );
        });
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
