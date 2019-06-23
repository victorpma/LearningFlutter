import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List tarefas = [];
  Map<String, dynamic> _ultimaTarefaRemovida = new Map();
  int _posicaoUltimaTarefaRemovida;

  TextEditingController _textTarefaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _lerDados().then((dados) {
        tarefas = json.decode(dados);
      });
    });
  }

  void _adicionarTarefa() {
    setState(() {
      Map<String, dynamic> novaTarefa = new Map();
      novaTarefa["title"] = _textTarefaController.text;
      novaTarefa["ok"] = false;
      _textTarefaController.text = "";
      tarefas.add(novaTarefa);
      _salvarDados();
    });
  }

  Future<File> _obterArquivo() async {
    final diretorio = await getApplicationDocumentsDirectory();

    return File("${diretorio.path}/tarefas.json");
  }

  Future<File> _salvarDados() async {
    var dados = json.encode(tarefas);

    final arquivo = await _obterArquivo();

    return arquivo.writeAsString(dados);
  }

  Future<String> _lerDados() async {
    try {
      final arquivo = await _obterArquivo();

      return arquivo.readAsString();
    } catch (ex) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Lista de Tarefas"),
          backgroundColor: Colors.blue,
          centerTitle: true),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              labelText: "Nova Tarefa",
                              labelStyle: TextStyle(color: Colors.blue)),
                          style: TextStyle(color: Colors.blue),
                          controller: _textTarefaController)),
                  RaisedButton(
                    child: Text("ADD"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: _adicionarTarefa,
                  )
                ],
              )),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: tarefas.length,
                itemBuilder: buildItemTarefa),
          )
        ],
      ),
    );
  }

  Widget buildItemTarefa(context, index) {
    return Dismissible(
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        child: CheckboxListTile(
            title: Text(tarefas[index]["title"]),
            value: tarefas[index]["ok"],
            secondary: CircleAvatar(
              child: Icon(
                  tarefas[index]["ok"] == true ? Icons.check : Icons.error),
            ),
            onChanged: (checked) {
              setState(() {
                tarefas[index]["ok"] = checked;
              });
            }),
        onDismissed: (direction) {
          setState(() {
            _ultimaTarefaRemovida = Map.from(tarefas[index]);
            _posicaoUltimaTarefaRemovida = index;
            tarefas.removeAt(index);

            _salvarDados();

            final snackBar = SnackBar(
                duration: Duration(seconds: 2),
                content:
                    Text("Tarefa \"${_ultimaTarefaRemovida["title"]}\" removida"),
                action: SnackBarAction(
                    label: "Desfazer",
                    onPressed: () {
                      setState(() {
                        tarefas.insert(_posicaoUltimaTarefaRemovida,
                            _ultimaTarefaRemovida);
                        _salvarDados();
                      });
                    }));

            Scaffold.of(context).showSnackBar(snackBar);
          });
        });
  }
}
