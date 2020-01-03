import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductModel.fromDocument(DocumentSnapshot documentSnapshot) {
    this.title = documentSnapshot.data["title"];
    this.description = documentSnapshot.data["description"];
    this.price = documentSnapshot.data["price"];
    this.images = documentSnapshot.data["images"];
    this.sizes = documentSnapshot.data["sizes"];
  }
}