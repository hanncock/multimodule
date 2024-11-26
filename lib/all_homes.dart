/*import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/getxMainDash.dart';
import 'package:web3/custom_display/keepAlive.dart';

import 'Constants/Menus.dart';
import 'Constants/Reusableswidgets/btns.dart';
import 'Constants/Theme.dart';
import 'Screens/Wrapper.dart';
import 'Screens/communication/Email.dart';
import 'Screens/communication/Messaging.dart';
import 'Screens/settings/settings.dart';




var module;
var companyInView ;
var companyIdInView ;
class AllHomes extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const AllHomes({Key? key, required this.sessionStateStream}) : super(key: key);
  // const AllHomes({super.key});

  @override
  State<AllHomes> createState() => _AllHomesState();
}

class _AllHomesState extends State<AllHomes> with TickerProviderStateMixin{

  late TabController controller2;
  List allowed = Userdata['allowedCompanies'];

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

  @override
  void initState() {
    super.initState();
    setCompany();
  }


  @override
  Widget build(BuildContext context) {
    TapController tapController = Get.put(TapController());
    print("here is active${tapController.actvTab}");

    return Scaffold(
      body: Container(
              // width: 600,
              child: GetBuilder<TapController>(
                  builder: (tapController) {
                  return DefaultTabController(
                    initialIndex: tapController.actvTab,
                      length: tapController.openScreenstitlles.length,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.grey[200]
                                  ),
                                  width: MediaQuery.of(context).size.width - 250,
                                  height: MediaQuery.of(context).size.height * 0.95,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: tapController.openScreenstitlles
                                          .map((widget) => KeepPageAlive(child: widget.widget),).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  child: TabBar(
                                      dividerColor: Colors.transparent,
                                      indicator: BoxDecoration(
                                          color:  Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.black54,
                                      isScrollable:true,
                                      tabs: List.generate(
                                        growable: true,
                                          tapController.openScreenstitlles.length,
                                              (index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${tapController.openScreenstitlles[index].title}'),
                                      )),
                                      // tabs: tapController.openScreenstitlles.map((title) =>Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.start,
                                      //     children: [
                                      //       Text('${title.title}'),
                                      //
                                      //       SizedBox(width: 10,),
                                      //       title.title == 'AllDash'?Text('') : InkWell(
                                      //         onTap: (){
                                      //           tapController.deleteTab(title);
                                      //         },
                                      //         child: CircleAvatar(
                                      //           radius: 8,
                                      //           child: Icon(Icons.close,color: Colors.red,size: 10,),),
                                      //       )
                                      //     ],
                                      //   )
                                      // ),).toList()
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      width: 1,
                                      color: Colors.grey.shade200
                                  ),
                                ),
                                child: Row(children: [
                                  btns(label: 'More',icona: Icon(Icons.arrow_drop_up_outlined))
                                ]),

                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            PopupMenuButton(
                                                child: btns(label: 'Switch Company',icona: Icon(Icons.switch_access_shortcut_add),),
                                                itemBuilder: (BuildContext context){
                                                  return allowed.map((e){
                                                    return  PopupMenuItem(child: InkWell(
                                                        onTap: ()async{
                                                          Map compData = {
                                                            "companyName":e['companyName'],
                                                            "companyId":e['id'],
                                                          };
                                                          SharedPreferences pref = await SharedPreferences.getInstance();
                                                          pref.setString("compData", jsonEncode(compData));
                                                          setCompany();
                                                          tapController.openScreenstitlles.clear();
                                                          Navigator.push(context, MaterialPageRoute(
                                                              builder: (_) =>
                                                                  Wrapper(sessionStateStream: widget
                                                                      .sessionStateStream,)));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(12.0),
                                                              child: Text('${e['companyName']}'),
                                                            ),
                                                          ],
                                                        )));
                                                  }).toList();
                                                }
                                            ),
                                            SizedBox(height: 10),
                                            btns(label:'Messaging',icona: Icon(Icons.sms,size: 14,),
                                              onclick: (){
                                                tapController.addtoList(messaging);

                                              },

                                            ),
                                            SizedBox(height: 10),
                                            btns(label:'Email',icona: Icon(Icons.email,size: 14,),
                                              onclick: (){
                                                tapController.addtoList(emailing);
                                              },
                                            ),
                                            SizedBox(height: 8),
                                            btns(label: '${Userdata['firstName']}',
                                              icona: Icon(Icons.settings,size: 14,),
                                              onclick: (){
                                                tapController.addtoList(settings);

                                                // if(openScreens.contains(settings)){
                                                //   setState(() {
                                                //     controller = TabController(
                                                //       length: openScreens.length,
                                                //       vsync: this,
                                                //       // initialIndex: tab_index,
                                                //     );
                                                //     currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                                //     var activeIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                                //     // DefaultTabController.of(context).animateTo(activeIndex);
                                                //     controller.animateTo(activeIndex);
                                                //     module = settings.title;
                                                //   });
                                                //
                                                //
                                                // }else{
                                                //   setState(() {
                                                //     openScreens.add(settings);
                                                //     controller = TabController(
                                                //       length: openScreens.length,
                                                //       vsync: this,
                                                //       // initialIndex: tab_index,
                                                //     );
                                                //     currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                                //     var activeIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                                //     controller.animateTo(activeIndex);
                                                //   });
                                                // }
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            btns(label:'Logout',icona: Icon(Icons.logout,size: 14,),color: Colors.red,
                                              onclick: (){
                                              tapController.openScreenstitlles.clear();
                                                clearlogs();
                                                Navigator.pushAndRemoveUntil(
                                                    context, MaterialPageRoute(builder: (context) => Wrapper(sessionStateStream: widget.sessionStateStream,)), (
                                                    route) => false);
                                              },
                                            ),
                                            SizedBox(height: 10),

                                          ],
                                        )
                                    ),
                                  ];
                                },
                              )
                            ],
                          )
                        ],
                      )
                  );
                }
              ),

      ),
    );
  }
}*/
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Constants/Menus.dart';
import 'package:web3/Screens/accounting/AccountsDash.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/Screens/dms/dmsdash.dart';
import 'package:web3/Screens/hrm/hrmdash.dart';
import 'package:web3/Screens/school/addStudent.dart';
import 'package:web3/custom_display/keepAlive.dart';
import 'Constants/calender.dart';
import 'Screens/Wrapper.dart';
import 'Screens/communication/Email.dart';
import 'Screens/communication/Messaging.dart';
import 'Screens/crm/crm_menus.dart';
import 'package:web3/Screens/crm/screen%20display.dart';
import 'package:web3/Screens/crm/CrmsMenuList.dart';
import 'Screens/school/school_alldisps.dart';
import 'Screens/settings/settings.dart';

class AllHomes extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const AllHomes({Key? key, required this.sessionStateStream}) : super(key: key);

  @override
  State<AllHomes> createState() => _AllHomesState();
}

var module;
var companyInView ;//= Userdata['allowedCompanies'][0]['companyName'] ?? null;

var companyIdInView =2204;//= Userdata['allowedCompanies'][0]['id'] ?? null;
class _AllHomesState extends State<AllHomes> with TickerProviderStateMixin {

  // final AllHomes _controller = Get.put(AllHomes());

  late TabController controller;

  late List openScreens = [
    Menus(
      title: 'AllDash',
      widget: allDash(),
      // widget: AccountsDash(),
      // widget: Messaging(),
      // widget: MyHomePage(),
      // widget: Settings()
      // widget: ScreenDispSchl()
      // widget: AddStudent()
      // widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),)
    ),
  ];


  int currentIndex = 0;

  List allowed = Userdata['allowedCompanies'];
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
    Menus(
      icona: Icon(Icons.manage_accounts,size: 40,),
      title: 'HRM',
      widget: HRMDash(),
    ),

  ];

  final List menus = [];

  List modulesaccquired = [];
  List modsacq = [];
  List modules = [];

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

    for(int i=0; i<modulesaccquired.length; i++){
      var found = modules.indexWhere((element) => element['id'] == modulesaccquired[i]);
      var menutoadd = menusListed.indexWhere((elem) => elem.title == modules[found]['moduName']);
      menus.add(menusListed[menutoadd]);
    }
    setState(() {});
    return menus;
  }

  setCompany()async{

    SharedPreferences user = await SharedPreferences.getInstance();
    var data = user.getString('compData');

    if(data == null){
      setState(() {
        companyInView = Userdata['allowedCompanies'][0]['companyName'];
        companyIdInView = Userdata['allowedCompanies'][0]['id'];
      });
    }else{
      var svdVals = jsonDecode(data);
      var compSvdVals = svdVals;

      setState(() {
        companyInView =svdVals['companyName'];
        companyIdInView = svdVals['companyId'];
      });
    }




  }


  Future _calculation = Future.delayed(
      const Duration(seconds: 1),
          () => 'soke'
  );


  @override
  void initState() {
    super.initState();
    // sess = widget.sessionStateStream;
    controller = TabController(
      length: openScreens.length,
      vsync: this,
      // initialIndex: tab_index,
    );
    setCompany().whenComplete((){
      getCompanyModules();
      getModules().whenComplete((){
        fetchmods();});
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: DefaultTabController(
        length: openScreens.length,
        // initialIndex: 0,
        initialIndex: currentIndex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height -100 ,
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      openScreens.length,
                          (index) => KeepPageAlive(child: openScreens[index].widget,),
                    )
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    // color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabBar(
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color:  Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black54,
                            isScrollable:true,
                            tabs: List.generate(
                              growable:true,
                              openScreens.length, (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              // child: Text('${openScreens[index].title}',style: TextStyle(color: Colors.white),),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${openScreens[index].title}',style: header2Dash,),
                                  // Text('${companyInView}',style: header2Dash,),
                                  SizedBox(width: 10,),
                                  index == 0? SizedBox() : InkWell(
                                      onTap: (){
                                        setState(() {

                                          if(openScreens[index].title == settings.title){
                                            currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                            openScreens.removeAt(currentIndex);
                                            currentIndex = currentIndex -1;
                                          }else{
                                            currentIndex = openScreens.indexWhere((element) => openScreens[index].title == element.title);
                                            openScreens.removeAt(currentIndex);
                                            currentIndex = currentIndex - 1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.close,size: 10,color: Colors.red,))
                                ],
                              ),
                            ),
                            )
                        ),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 1,
                                color: Colors.grey.shade200
                            ),
                          ),
                          child: Row(children: [
                            btns(label: 'More',icona: Icon(Icons.arrow_drop_up_outlined))
                          ]),

                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PopupMenuButton(
                                          child: btns(label: 'Switch Company',icona: Icon(Icons.switch_access_shortcut_add),),
                                          itemBuilder: (BuildContext context){
                                            return allowed.map((e){
                                              return  PopupMenuItem(child: InkWell(
                                                  onTap: ()async{
                                                    Map compData = {
                                                      "companyName":e['companyName'],
                                                      "companyId":e['id'],
                                                    };
                                                    SharedPreferences pref = await SharedPreferences.getInstance();
                                                    pref.setString("compData", jsonEncode(compData));
                                                    setCompany();
                                                    openScreens.clear();
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (_) =>
                                                            Wrapper(sessionStateStream: widget
                                                                .sessionStateStream,)));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(12.0),
                                                        child: Text('${e['companyName']}'),
                                                      ),
                                                    ],
                                                  )));
                                            }).toList();
                                          }
                                      ),
                                      SizedBox(height: 10),
                                      btns(label:'Messaging',icona: Icon(Icons.sms,size: 14,),
                                        onclick: (){
                                          if(openScreens.contains(messaging)){
                                            setState(() {

                                              currentIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                              var activeIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                              print("here is the index${activeIndex}");
                                              print("here is the current index${currentIndex}");
                                              // DefaultTabController.of(context).animateTo(activeIndex);
                                              controller = TabController(
                                                length: openScreens.length,
                                                vsync: this,
                                                initialIndex: activeIndex,
                                              );
                                              // module = messaging.title;
                                              // DefaultTabController.of(context).animateTo(currentIndex);

                                            });


                                          }else{
                                            // setState(() {
                                            print('adding');
                                            openScreens.add(messaging);
                                            controller = TabController(
                                              length: openScreens.length,
                                              vsync: this,
                                              // initialIndex: tab_index,
                                            );

                                            currentIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                            var activeIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                            print("here is the index on adding${activeIndex}");
                                            print("here is the current  index on adding${currentIndex}");
                                            // DefaultTabController.of(context).animateTo(activeIndex);
                                            // controller = TabController(
                                            //   length: openScreens.length,
                                            //   vsync: this,
                                            //   // initialIndex: activeIndex,
                                            // );
                                            controller.animateTo(currentIndex);

                                            // currentIndex = openScreens.indexWhere((element) => settings.title == element.title);


                                            // var activeIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                            // controller.animateTo(activeIndex);
                                            // DefaultTabController.of(context).animateTo(currentIndex);
                                            // print(openScreens);
                                            // });
                                          }
                                        },
                                        //   onclick: (){
                                        //     if(openScreens.contains(messaging)){
                                        //       setState(() {
                                        //
                                        //         currentIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                        //         // var activeIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                        //         // print("here is the index${activeIndex}");
                                        //         // DefaultTabController.of(context).animateTo(activeIndex);
                                        //         controller = TabController(
                                        //           length: openScreens.length,
                                        //           vsync: this,
                                        //           // initialIndex: activeIndex,
                                        //         );
                                        //         // module = messaging.title;
                                        //         // DefaultTabController.of(context).animateTo(currentIndex);
                                        //
                                        //       });
                                        //
                                        //
                                        //     }else{
                                        //       setState(() {
                                        //         print('adding');
                                        //         openScreens.add(messaging);
                                        //         controller = TabController(
                                        //           length: openScreens.length,
                                        //           vsync: this,
                                        //           // initialIndex: tab_index,
                                        //         );
                                        //         currentIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                        //         // var activeIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                        //         controller.animateTo(currentIndex);
                                        //         // DefaultTabController.of(context).animateTo(currentIndex);
                                        //         // print(openScreens);
                                        //       });
                                        //     }
                                        // },
                                      ),
                                      SizedBox(height: 10),
                                      btns(label:'Email',icona: Icon(Icons.email,size: 14,),
                                        onclick: (){
                                          if(openScreens.contains(emailing)){
                                            setState(() {
                                              controller = TabController(
                                                length: openScreens.length,
                                                vsync: this,
                                                // initialIndex: tab_index,
                                              );
                                              currentIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              var activeIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              // DefaultTabController.of(context).animateTo(activeIndex);
                                              controller.animateTo(currentIndex);
                                              module = emailing.title;
                                            });
                                          }else{
                                            controller = TabController(
                                              length: openScreens.length,
                                              vsync: this,
                                              // initialIndex: tab_index,
                                            );
                                            setState(() {
                                              openScreens.add(emailing);

                                              currentIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              print(currentIndex);
                                              var activeIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              controller.animateTo(activeIndex);
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      btns(label: '${Userdata['firstName']}',
                                        icona: Icon(Icons.settings,size: 14,),
                                        onclick: (){
                                          if(openScreens.contains(settings)){
                                            setState(() {
                                              controller = TabController(
                                                length: openScreens.length,
                                                vsync: this,
                                                // initialIndex: tab_index,
                                              );
                                              currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                              var activeIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                              // DefaultTabController.of(context).animateTo(activeIndex);
                                              controller.animateTo(activeIndex);
                                              module = settings.title;
                                            });


                                          }else{
                                            setState(() {
                                              openScreens.add(settings);
                                              controller = TabController(
                                                length: openScreens.length,
                                                vsync: this,
                                                // initialIndex: tab_index,
                                              );
                                              currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                              var activeIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                              controller.animateTo(activeIndex);
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      btns(label:'Logout',icona: Icon(Icons.logout,size: 14,),color: Colors.red,
                                        onclick: (){
                                          clearlogs();
                                          Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(builder: (context) => Wrapper(sessionStateStream: widget.sessionStateStream,)), (
                                              route) => false);
                                        },
                                      ),
                                      SizedBox(height: 10),

                                    ],
                                  )
                              ),
                            ];
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding allDash() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: _calculation,
          builder: (context,snapshot){
            return Container(
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
                        if(openScreens.contains(menus[index])){
                          currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          module = menus[index].title;
                          setState(() {});
                          DefaultTabController.of(context).animateTo(currentIndex);
                        }else{
                          openScreens.add(menus[index]);
                          currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          setState(() {});
                          DefaultTabController.of(context).animateTo(currentIndex);
                          // var activeIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          // DefaultTabController.of(context).animateTo(activeIndex - 1);

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
            );
          }),
    );

  }

}