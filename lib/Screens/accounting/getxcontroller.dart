import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3/Screens/accounting/newInvoice.dart';

import 'acctsStats.dart';

class TapController extends GetxController{
  int _x = 0;
  int get x => _x;

  late TabController _controller2;

  get controller2 => _controller2;

  int _actvTab = 0;
  int get actvTab => _actvTab;


  List _openScreenstitlles = ['Dashboard'];
  // final openScreensWidgetts = <dynamic>[AccntStats()];
  final openScreensWidgetts = <dynamic>[NewInvoice()];

  List get openScreenstitlles => _openScreenstitlles;


  void increaseX(){
    _x++;
    print(_x);
  }


  void addtoList(value,widget){
    _openScreenstitlles.add(value);
    openScreensWidgetts.add(widget);
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