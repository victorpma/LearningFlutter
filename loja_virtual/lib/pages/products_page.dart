import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product_model.dart';
import 'package:loja_virtual/widgets/product_tile.dart';

class ProductsPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  ProductsPage(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.documentSnapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("produtos")
              .document(documentSnapshot.documentID)
              .collection("itens")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 0.65),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                          "grid",
                          ProductModel.fromDocument(
                              snapshot.data.documents[index]));
                    }),
                ListView.builder(                  
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                        "list",
                        ProductModel.fromDocument(
                            snapshot.data.documents[index]));
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
