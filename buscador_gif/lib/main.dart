import 'package:flutter/material.dart';
import 'package:buscador_gif/UI/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: "Buscador de GIFs",
    home: HomePage(),
    theme: ThemeData(accentColor: Colors.white, hintColor: Colors.white),
  ));
}
