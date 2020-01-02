import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        drawer: CustomDrawer(),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomeTab(),
          ],
        ));
  }
}
