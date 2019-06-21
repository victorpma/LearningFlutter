import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=5091ebd6";

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
  TextEditingController _controllerReais = TextEditingController();
  TextEditingController _controllerDolares = TextEditingController();
  TextEditingController _controllerEuros = TextEditingController();

  double dolar;
  double euro;

  Future<Map> _obterCotacao() async {
    http.Response response = await http.get(request);

    if (response != null) return json.decode(response.body);

    throw new Exception();
  }

  void _resetarCampos() {
    _controllerReais.text = "";
    _controllerDolares.text = "";
    _controllerEuros.text = "";
  }

  void _reaisChanged(String text) {
    if (text.isEmpty) _resetarCampos();

    double real = double.parse(text);

    _controllerDolares.text = (real / dolar).toStringAsPrecision(2);
    _controllerEuros.text = (real / euro).toStringAsPrecision(2);
  }

  void _dolaresChanged(String text) {
    if (text.isEmpty) _resetarCampos();

    double dolar = double.parse(text);

    _controllerReais.text = (dolar * this.dolar).toStringAsPrecision(2);
    _controllerEuros.text =
        (dolar * this.dolar / this.euro).toStringAsPrecision(2);
  }

  void _eurosChanged(String text) {
    if (text.isEmpty) _resetarCampos();

    double euro = double.parse(text);

    _controllerDolares.text =
        (euro * this.euro / this.dolar).toStringAsPrecision(2);
    _controllerReais.text =
        (euro * this.euro / this.dolar).toStringAsPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Conversor de Moedas"),
          backgroundColor: Colors.amber,
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetarCampos)
          ],
        ),
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
                this.dolar =
                    snapshot.data["results"]["currencies"]["USD"]["buy"];
                this.euro =
                    snapshot.data["results"]["currencies"]["EUR"]["buy"];

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
        keyboardType: TextInputType.numberWithOptions(decimal: true),
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
