import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final PageController pageController;
  final int page;

  DrawerTile({this.title, this.icon, this.pageController, this.page});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          child: Container(
            height: 60.0,
            child: Row(
              children: <Widget>[
                Icon(icon,
                    size: 32.0,
                    color: pageController.page.round() == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700]),
                Padding(
                  padding: EdgeInsets.only(right: 32),
                ),
                Text(title,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: pageController.page.round() == page
                            ? Theme.of(context).primaryColor
                            : Colors.grey[700]))
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            this.pageController.jumpToPage(this.page);
          }),
    );
  }
}
