import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/category_tile.dart';

class ProductTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("produtos")
            .orderBy("title")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[700]),
              ),
            );
          else {
            return ListView(
                children: snapshot.data.documents.map((document) {
              return CategoryTile(document);
            }).toList());
          }
        });
  }
}
