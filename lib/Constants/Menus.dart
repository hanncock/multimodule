import 'package:flutter/material.dart';

class Menus{

  String title;
  Widget widget;
  final Icon? icona;


  Menus({
    required this.title,
    required this.widget,
    this.icona
  });
}