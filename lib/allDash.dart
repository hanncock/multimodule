import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/Menus.dart';
import 'Constants/Theme.dart';
import 'Screens/Wrapper.dart';
import 'Screens/accounting/AccountsDash.dart';
import 'Screens/communication/Email.dart';
import 'Screens/communication/Messaging.dart';
import 'Screens/crm/CrmsMenuList.dart';
import 'Screens/crm/crm_menus.dart';
import 'Screens/crm/screen display.dart';
import 'Screens/dashboard.dart';
import 'Screens/dms/dmsdash.dart';
import 'Screens/school/school_alldisps.dart';
import 'Screens/settings/settings.dart';
import 'all_homes.dart';
import 'getxMainDash.dart';

class AllDash extends StatefulWidget {
  const AllDash({super.key});

  @override
  State<AllDash> createState() => _AllDashState();
}

class _AllDashState extends State<AllDash> {

  final List menus = [];




  late List openScreens = [
    Menus(
      title: 'AllDash',
      // widget: allDash(),
      widget: AccountsDash(),
      // widget: Messaging(),
      // widget: MyHomePage(),
      // widget: Settings()
      // widget: ScreenDispSchl()
      // widget: AddStudent()
      // widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),)
    ),
  ];

  // List allowed = Userdata['allowedCompanies'];
  var settings = Menus(
      title: 'Settings',
      widget: Settings()
  );

  var messaging = Menus(
      title: 'Messaging',
      widget: Messaging()
  );

  var emailing = Menus(
      title: 'Email',
      widget: Emailing()
  );


  List menusListed = [

    Menus(
        icona: Icon(Icons.school,size: 40,),
        title: 'School',
        widget: ScreenDispSchl()
    ),
    Menus(
        icona: Icon(Icons.house,size: 40,),
        title: 'Home',
        widget: Dashboard()
    ),
    Menus(
      icona: Icon(Icons.people,size: 40,),
      title: 'CRM',
      widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),),
    ),
    Menus(
      icona: Icon(Icons.people,size: 40,),
      title: 'will del',
      widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),),
    ),
    Menus(
      icona: Icon(Icons.document_scanner,size: 40,),
      title: 'DMS',
      widget: DMS(),
    ),
    Menus(
      icona: Icon(Icons.currency_bitcoin_rounded,size: 40,),
      title: 'Finance',
      widget: AccountsDash(),
    ),

  ];


  List modulesaccquired = [];
  List modsacq = [];
  List modules = [];

  setCompany()async {
    SharedPreferences user = await SharedPreferences.getInstance();
    var data = user.getString('compData');

    if (data == null) {
      setState(() {
        companyInView = Userdata['allowedCompanies'][0]['companyName'];
        companyIdInView = Userdata['allowedCompanies'][0]['id'];
      });
    } else {
      var svdVals = jsonDecode(data);
      var compSvdVals = svdVals;

      setState(() {
        companyInView = svdVals['companyName'];
        companyIdInView = svdVals['companyId'];
      });
    }
  }

  getCompanyModules()async{
    var resu = await auth.getvalues('settings/companymodule/list?companyId=${companyIdInView}');
    modsacq = resu;
    modulesaccquired.clear();
    for(int i=0; i<resu.length; i++){
      modulesaccquired.add(resu[i]['moduleId']);
    }
    setState(() {});
  }

  getModules()async{
    var resu = await auth.getvalues('settings/module/list');
    setState(() {
      modules = resu;
    });
  }

  fetchmods(){
    print('fetching modules');
    for(int i=0; i<modulesaccquired.length; i++){
      var found = modules.indexWhere((element) => element['id'] == modulesaccquired[i]);
      var menutoadd = menusListed.indexWhere((elem) => elem.title == modules[found]['moduName']);
      menus.add(menusListed[menutoadd]);
    }
    print(menus);
    setState(() {});
    print('loading modules complete');
    return menus;
  }



  Future _calculation = Future.delayed(
      const Duration(seconds: 1),
          () => 'soke'
  );


  @override
  void initState() {
    super.initState();
    setCompany().whenComplete((){
      getCompanyModules();
      getModules().whenComplete((){
        fetchmods();});
    });
  }




  @override
  Widget build(BuildContext context) {
    print(menus);
    TapController tapController = Get.put(TapController());
    return  Card(
      elevation: 0,
        child: Container(
            child:GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: menus.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                    crossAxisCount: 4,
                    childAspectRatio: 1.5
                ),
                itemBuilder: (context,index) => GestureDetector(
                  onTap: (){
                    if(tapController.openScreenstitlles.contains(menus[index])){
                      print('contains ${menus[index].title}');
                      // DefaultTabController.of(context).animateTo(tapController.actvTab);
                    }else {
                      tapController.addtoList(menus[index]);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          menus[index].icona,

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${menus[index].title}',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            )
        )

    );
  }
}
