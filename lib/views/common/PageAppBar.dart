import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {

  String title;

  PageAppBar({@required this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(title: new Text(this.title));
  }
}
