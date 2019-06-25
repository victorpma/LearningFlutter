import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _pesquisa;
  Map<String, dynamic> gifs = new Map();

  Future<Map> _obterGifs() async {
    http.Response response;

    if (_pesquisa == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=JdO9eFYCIfQ6t0HBuBTIuqgSoCE4f6Dc&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=JdO9eFYCIfQ6t0HBuBTIuqgSoCE4f6Dc&q=$_pesquisa&limit=20&offset=0&rating=G&lang=en");

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _obterGifs().then((gifs) {
      print(gifs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
                child: FutureBuilder(
              future: _obterGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                        child: new CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ));
                    break;
                  default:
                    return _criarTabelaGifs(context, snapshot);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}

Widget _criarTabelaGifs(BuildContext context, AsyncSnapshot snapshot) {
  return GridView.builder(
      itemCount: snapshot.data["data"].length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Image.network(
          snapshot.data["data"][index]["images"]["fixed_height"]["url"],
          height: 300,
          fit: BoxFit.cover,
        ));
      });
}
