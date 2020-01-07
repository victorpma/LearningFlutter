import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/products_page.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  CategoryTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(documentSnapshot.data["icon"]),
      ),
      title: Text(documentSnapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductsPage(documentSnapshot)));
      },
    ));
  }
}
