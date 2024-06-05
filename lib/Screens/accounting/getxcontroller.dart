import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'acctsStats.dart';

class TapController extends GetxController{
  int _x = 0;
  int get x => _x;

  late TabController _controller2;

  get controller2 => _controller2;

  int _actvTab = 0;
  int get actvTab => _actvTab;


  List _openScreenstitlles = ['Dashboard'];
  final openScreensWidgetts = <dynamic>[AccntStats()];

  List get openScreenstitlles => _openScreenstitlles;


  void increaseX(){
    _x++;
    print(_x);
  }


  void addtoList(value,widget){
    _openScreenstitlles.add(value);
    openScreensWidgetts.add(widget);
    print('here are the titles ${openScreenstitlles}');
    print('here are the screens ${openScreensWidgetts}');
    update();

    // print(_openScreenstitlles.length);
    // print(value);
  }

  void switchTo(value){
    _actvTab = openScreenstitlles.indexWhere((element) => element == value);
    print(_actvTab);
    update();
  }

  void printList() {
    print("here is widgets ${openScreensWidgetts}");
    // setState((){});
    update();
  }

    void deleteTab(value){
      var actv = value;
      print(value);

      if(_openScreenstitlles.length > 0){
        _actvTab = value - 1;
      }else{
        _actvTab = 0;
      }
      openScreenstitlles.removeAt(value);
      openScreensWidgetts.removeAt(value);
      // var val = _openScreenstitlles.indexWhere((element) => element == value);
      // _openScreenstitlles.removeWhere((element) => element == value);
      update();
    }

}