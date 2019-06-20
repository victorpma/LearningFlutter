import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=5091ebd6";

TextEditingController _controllerReais = TextEditingController();
TextEditingController _controllerDolares = TextEditingController();
TextEditingController _controllerEuros = TextEditingController();

void _reaisChanged(String text) {
  print(text);
}

void _dolaresChanged(String text) {
  print(text);
}

void _eurosChanged(String text) {
  print(text);
}

void main() {
  runApp(MaterialApp(
    title: "Conversor de Moedas",
    color: Colors.amber,
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _obterCotacao() async {
    http.Response response = await http.get(request);

    if (response != null) return json.decode(response.body);

    throw new Exception();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Conversor de Moedas"),
            backgroundColor: Colors.amber,
            centerTitle: true),
        body: FutureBuilder<Map>(
          future: _obterCotacao(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                );
              default:
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          color: Colors.amber, size: 150.0),
                      _textFieldMoney(
                          "Reais", "R\$", _controllerReais, _reaisChanged),
                      Divider(),
                      _textFieldMoney("Dólares", "US\$", _controllerDolares,
                          _dolaresChanged),
                      Divider(),
                      _textFieldMoney(
                          "Euros", "€", _controllerEuros, _eurosChanged)
                    ],
                  ),
                );
            }
          },
        ));
  }

  Widget _textFieldMoney(String text, String prefix,
      TextEditingController controller, Function changed) {
    return TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: Colors.amber),
            border: OutlineInputBorder(),
            prefix: Text("$prefix")),
        style: TextStyle(color: Colors.amber, fontSize: 25.0),
        controller: controller,
        onChanged: changed);
  }
}
