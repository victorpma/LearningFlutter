import 'dart:io';

import 'package:agenda_contatos/domain/models/contato.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  final Contato contato;

  ContatoPage({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  Contato _edicaoContato;
  bool _editou = false;

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  final _nomeFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contato == null) {
      _edicaoContato = new Contato();
    } else {
      _edicaoContato = Contato.fromMap(widget.contato.toMap());

      _nomeController.text = _edicaoContato.nome;
      _emailController.text = _edicaoContato.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _exibirPopAlteracao(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(_edicaoContato.nome ?? "Novo Contato"),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _edicaoContato.avatar != null
                              ? FileImage(File(_edicaoContato.avatar))
                              : AssetImage("images/avatar.png")),
                    ),
                  ),
                ),
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: "Nome"),
                  focusNode: _nomeFocus,
                  onChanged: (text) {
                    _editou = true;
                    setState(() {
                      _edicaoContato.nome = text;
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) {
                    _editou = true;
                    _edicaoContato.email = text;
                  },
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.save),
            onPressed: () {
              if (_edicaoContato.nome != null && _edicaoContato.nome.isNotEmpty)
                Navigator.pop(context, _edicaoContato);
              else
                FocusScope.of(context).requestFocus(_nomeFocus);
            },
          ),
        ));
  }

  _exibirPopAlteracao() {
    if (_editou) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Deseja cancelar as alterações?"),
              content: Text("Se cancelar, as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    
                  },
                )
              ],
            );
          });
    }
  }
}
