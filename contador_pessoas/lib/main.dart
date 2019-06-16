import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contador de Pessoas", home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _quantidadePessoas = 0;
  String _statusRestaurante = "Pode Entrar!";

  void _changeQuantidadePessoas(int quantidade) {
    setState(() {
      _quantidadePessoas += quantidade;

      _statusRestaurante = _quantidadePessoas < 0
          ? "Mundo Invertido!"
          : _quantidadePessoas > 10 ? "Lotado!" : "Pode Entrar!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset("images/restaurante.jpg",
            fit: BoxFit.cover, height: 1000.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_quantidadePessoas",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "-1",
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                  onPressed: () {
                    _changeQuantidadePessoas(-1);
                  },
                ),
                FlatButton(
                  child: Text(
                    "+1",
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                  onPressed: () {
                    _changeQuantidadePessoas(1);
                  },
                )
              ],
            ),
            Text(
              "$_statusRestaurante",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 30.0),
            )
          ],
        ),
      ],
    );
  }
}
