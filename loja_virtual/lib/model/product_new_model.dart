import 'package:cloud_firestore/cloud_firestore.dart';

class ProductNewMode{
  int height;
  int width;
  int position;
  String image;

  ProductNewMode.fromDocument(DocumentSnapshot documentSnapshot){
    this.height = documentSnapshot.data["height"];
    this.width = documentSnapshot.data["width"];
    this.position = documentSnapshot.data["position"];
    this.image = documentSnapshot.data["image"];
  }  
}