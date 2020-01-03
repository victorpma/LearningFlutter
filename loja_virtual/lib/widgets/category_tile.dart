import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String icon;

  CategoryTile(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(icon),
      ),
      title: Text(this.title),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    ));
  }
}
