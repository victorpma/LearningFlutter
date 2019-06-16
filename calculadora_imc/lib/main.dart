import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();
  String _informacao = "Informe seus dados!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetarCampos() {
    _pesoController.text = " ";
    _alturaController.text = " ";
    setState(() {
      _informacao = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;

      double imc = peso / (altura * altura);

      print(imc);

      if (imc < 18.6)
        _informacao = "Abaixo do Peso! (${imc.toStringAsPrecision(3)})";
      else if (imc >= 18.6 && imc < 24.9)
        _informacao = "Peso Ideal! (${imc.toStringAsPrecision(3)})";
      else if (imc >= 24.0 && imc < 29.9)
        _informacao =
            "Levemente Acima do Peso! (${imc.toStringAsPrecision(3)})";
      else if (imc >= 29.9 && imc < 34.9)
        _informacao = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      else if (imc >= 34.9 && imc < 39.9)
        _informacao = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      else if (imc >= 40)
        _informacao = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetarCampos)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.person_outline,
                            color: Colors.green, size: 120.0),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Peso (Kg)",
                                labelStyle: TextStyle(color: Colors.green)),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.green, fontSize: 25.0),
                            controller: _pesoController,
                            validator: (value) {
                              if (value.isEmpty) return "Campo Obrigatório!";
                            }),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Altura (cm)",
                                labelStyle: TextStyle(color: Colors.green)),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.green, fontSize: 25.0),
                            controller: _alturaController,
                            validator: (value) {
                              if (value.isEmpty) return "Campo Obrigatório!";
                            }),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 10.0),
                            child: Container(
                              height: 50.0,
                              child: RaisedButton(
                                  color: Colors.green,
                                  child: Text(
                                    "Calcular",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate())
                                      _calcularIMC();
                                  }),
                            )),
                        Text(_informacao,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.green, fontSize: 20.0))
                      ],
                    )))));
  }
}
