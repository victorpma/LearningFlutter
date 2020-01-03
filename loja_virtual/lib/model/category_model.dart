import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String title;
  String icon;

  CategoryModel.fromDocument(DocumentSnapshot documentSnapshot) {
    this.title = documentSnapshot.data["title"];
    this.icon = documentSnapshot.data["icon"];
  }
}
