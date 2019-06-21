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
    return Container();
  }
}
