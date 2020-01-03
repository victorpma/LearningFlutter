import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyDrawer() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        );

    return Drawer(
        child: Stack(
      children: <Widget>[
        _buildBodyDrawer(),
        ListView(
          padding: EdgeInsets.only(left: 32.0, top: 16.0),
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text(
                          "Flutter's\nClothing",
                          style: TextStyle(
                              fontSize: 34.0, fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Olá,",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Entre ou Cadastre-se",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ))
                  ],
                )),
            Divider(),
            DrawerTile(
                title: "Início",
                icon: Icons.home,
                pageController: pageController,
                page: 0),
            DrawerTile(
                title: "Produtos",
                icon: Icons.list,
                pageController: pageController,
                page: 1),
            DrawerTile(
                title: "Lojas",
                icon: Icons.location_on,
                pageController: pageController,
                page: 2),
            DrawerTile(
                title: "Meus Pedidos",
                icon: Icons.playlist_add_check,
                pageController: pageController,
                page: 3),
          ],
        )
      ],
    ));
  }
}
