import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Constants/Menus.dart';
import 'Screens/accounting/AccountsDash.dart';
import 'Screens/communication/Messaging.dart';
import 'Screens/school/addStudent.dart';
import 'allDash.dart';
import 'all_homes.dart';

class TapController extends GetxController{
  int _x = 0;
  int get x => _x;

  late TabController _controller2;

  get controller2 => _controller2;

  int _actvTab = 0;
  int get actvTab => _actvTab;


  List _openMainDashScreenstitlles = [
    Menus(
      title: 'AllDash',
      // widget: allDash(),
      widget: AllDash(),
      // widget: AccountsDash(),
      // widget: Messaging(),
      // widget: MyHomePage(),
      // widget: Settings()
      // widget: ScreenDispSchl()
      // widget: AddStudent()
      // widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),)
    ),
  ];
  // final openScreensWidgetts = <dynamic>[AccntStats()];



  List get openScreenstitlles => _openMainDashScreenstitlles;


  void increaseX(){
    _x++;
    print(_x);
  }


  void addtoList(value){
    if(_openMainDashScreenstitlles.contains(value)){
      switchTo(value);
    }else{
      _openMainDashScreenstitlles.add(value);

    }
    // openScreensWidgetts.add(widget);
    update();

    // print(_openMainDashScreenstitlles.length);
    // print(value);
  }

  void switchTo(value){
    print('switching');
    _actvTab = openScreenstitlles.indexWhere((element) => element.title == value.title);
    print(_actvTab);
    update();
  }

  void printList() {
    print("here is widgets ${_openMainDashScreenstitlles}");
    // setState((){});
    update();
  }

  void deleteTab(value){
    print(value);
    var num = _openMainDashScreenstitlles.length;
    var val = _openMainDashScreenstitlles.indexWhere((element) => element.title == value.title);
    _openMainDashScreenstitlles.removeAt(val);
    if(_openMainDashScreenstitlles.length > 0){
      _actvTab = _openMainDashScreenstitlles.length - 1;
    }
    // var actv = value;
    // if(_openMainDashScreenstitlles.length > 0){
    //   _actvTab = value - 1;
    // }else{
    //   _actvTab = 0;
    // }
    // openScreenstitlles.removeAt(value);
    // openScreensWidgetts.removeAt(value);
    // _openMainDashScreenstitlles.removeWhere((element) => element == value);
    update();
  }

}