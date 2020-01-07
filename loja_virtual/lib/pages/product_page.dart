import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product_model.dart';

class ProductPage extends StatefulWidget {
  final ProductModel productModel;

  ProductPage(this.productModel);

  @override
  _ProductPageState createState() => _ProductPageState(this.productModel);
}

class _ProductPageState extends State<ProductPage> {
  final ProductModel productModel;

  _ProductPageState(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(productModel.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                productModel.title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
              ),
              Text(
                "R\$ ${productModel.price.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 24.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Tamanho",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Descrição",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                  )),
              Text(
                productModel.description,
                style: TextStyle(fontSize: 17.0),
              )
            ],
          ),
        ));
  }
}
