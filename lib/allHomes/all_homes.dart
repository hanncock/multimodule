import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Constants/Menus.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/Screens/homeScreen.dart';
import 'package:web3/custom_display/keepAlive.dart';
import '../Screens/Wrapper.dart';
import '../Screens/crm/crm_menus.dart';

import 'package:web3/Screens/crm/screen%20display.dart';
import 'package:web3/Screens/crm/CrmsMenuList.dart';

import '../Screens/settings/settings.dart';

class AllHomes extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const AllHomes({Key? key, required this.sessionStateStream}) : super(key: key);

  @override
  State<AllHomes> createState() => _AllHomesState();
}

var module;
var companyInView = Userdata['allowedCompanies'][0]['companyName'] ?? null;
var companyIdInView = Userdata['allowedCompanies'][0]['id'] ?? null;
class _AllHomesState extends State<AllHomes> with TickerProviderStateMixin {

  // final AllHomes _controller = Get.put(AllHomes());

  late TabController controller;

  late List openScreens = [
    Menus(
        title: 'AllDash',
        widget: allDash()
    ),
  ];


  int currentIndex = 0;

  var settings = Menus(
      title: 'Settings',
      widget: Settings()
  );

  List menus = [

    Menus(
        icona: Icon(Icons.school,size: 40,),
        title: 'School',
        widget: homeScreen()
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

  ];

  @override
  void initState() {
    super.initState();
    // sess = widget.sessionStateStream;
    controller = TabController(
      length: openScreens.length,
      vsync: this,
      // initialIndex: tab_index,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: openScreens.length,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height -100 ,
                child: TabBarView(
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
                            isScrollable:true,
                            tabs: List.generate(
                              growable:true,
                              openScreens.length, (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Text('${openScreens[index].title}',style: TextStyle(color: Colors.white),),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${openScreens[index].title}',style: header2Dash,),
                                    SizedBox(width: 10,),
                                    index == 0? SizedBox() : InkWell(
                                        onTap: (){
                                          setState(() {

                                            if(openScreens[index].title == settings.title){
                                              currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                              openScreens.removeAt(currentIndex);
                                            }else{
                                              currentIndex = openScreens.indexWhere((element) => openScreens[index].title == element.title);
                                              openScreens.removeAt(currentIndex);
                                            }
                                          });
                                        },
                                        child: Icon(Icons.close,size: 10,color: Colors.red,))
                                  ],
                                ),
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
                          child: Row(
                            children: [
                              // btns(label: 'Print',icona: Icon(Icons.manage_search_sharp),),
                              btns(label: 'More',icona: Icon(Icons.arrow_drop_up_outlined),),
                              // Icon(Icons.arrow_drop_down,)
                            ],
                          ),

                          // child: Text(''),
                          // icon: Icon(Icons.open_with_rounded,color: Colors.blue,),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 8),
                                      btns(label:'Logout',icona: Icon(Icons.logout),color: Colors.red,
                                        onclick: (){
                                        clearlogs();
                                        Navigator.pushAndRemoveUntil(
                                            context, MaterialPageRoute(builder: (context) => Wrapper(sessionStateStream: widget.sessionStateStream,)), (
                                            route) => false);
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      btns(label: '${Userdata['firstName']}',
                                        icona: Icon(Icons.settings),
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
                                      SizedBox(height: 8),
                                      // btns(label:'Logount',
                                      //   color: Colors.cyan,
                                      //   icona: Icon(Icons.logout),
                                      //   onclick: (){
                                      //     // upload(["clientName","clientId","clientEmail"],'Download');
                                      //     },)

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
          padding: const EdgeInsets.all(defaultPadding),
          child: Container(
              child: GridView.builder(
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
                        print(openScreens);
                        var activeIndex;
                          currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          // activeIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          module = menus[index].title;
                        setState(() {});
                        DefaultTabController.of(context).animateTo(currentIndex);


                      }else{
                        print(openScreens);
                          openScreens.add(menus[index]);
                          currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          print(currentIndex);
                          setState(() {});

                        var activeIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                        DefaultTabController.of(context).animateTo(activeIndex - 1);

                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          // color: Theme.of(context).primaryColor,
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
          ),
        );
  }

}
