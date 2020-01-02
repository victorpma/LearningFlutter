import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;

  DrawerTile({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          child: Container(
            height: 60.0,
            child: Row(
              children: <Widget>[
                Icon(icon, size: 32.0, color: Colors.black),
                Padding(
                  padding: EdgeInsets.only(right: 32),
                ),
                Text(title,
                    style: TextStyle(fontSize: 16.0, color: Colors.black))
              ],
            ),
          ),
          onTap: () {}),
    );
  }
}
