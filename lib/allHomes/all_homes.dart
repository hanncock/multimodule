import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Constants/Menus.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/Screens/homeScreen.dart';
import 'package:web3/custom_display/keepAlive.dart';

import '../Screens/Companies/CompaniesUI.dart';
import '../Screens/crm/crm_menus.dart';

import 'package:web3/Screens/crm/screen%20display.dart';

// import 'CrmsMenuList.dart';
// import 'crmCards.dart';
// import 'crm_menus.dart';
import 'package:web3/Screens/crm/CrmsMenuList.dart';

class AllHomes extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const AllHomes({Key? key, required this.sessionStateStream}) : super(key: key);

  @override
  State<AllHomes> createState() => _AllHomesState();
}

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
  List menus = [

    Menus(
        title: 'School',
        widget: homeScreen()
    ),
    Menus(
        title: 'Home',
        widget: Dashboard()
    ),
    Menus(
        title: 'UI Design',
        widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),),

  )

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
  void dispose(){
    controller.dispose();
    super.dispose();
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
                          (index) => KeepPageAlive(
                        // child: Text('Soke'),
                        child: openScreens[index].widget,
                      ),
                    )
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    // color: Theme.of(context).primaryColor,
                    child: TabBar(
                        isScrollable:true,
                        tabs: List.generate(
                          growable:true,
                          openScreens.length, (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: Text('${openScreens[index].title}',style: TextStyle(color: Colors.white),),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Text('${openScreens[index].title}',style: header2Dash,),
                          ),
                        ),
                        )
                    ),
                  ),
                ),
              ],
            ),



             // openScreens.length == 0 ? allDash()
                // :SingleChildScrollView(
                //   // scrollDirection: Axis.vertical,
                //   child: openScreens[currentIndex].widget
                // ),

            // openScreens.length == 0 ? allDash() : openScreens[currentIndex].widget,
            // openScreens.length == 0 ? allDash(): Row(
            //   children: List.generate(
            //       openScreens.length, (index) => KeepPageAlive(
            //     child: openScreens[index].widget,
            //   ))
            // ),


            // Card(
            //   elevation: 0,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: 35,
            //     child: Wrap(
            //       children: List.generate(
            //           openScreens.length, (index) => KeepPageAlive(
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 6.0),
            //               child: FilterChip(
            //                 backgroundColor: Colors.blueAccent,
            //         selectedColor: Colors.red,
            //         shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(20),
            //
            //         ),
            //               label: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text('${openScreens[index].title}',style: TextStyle(color: Colors.white),),
            //               ),
            //               onSelected: (val){
            //                 currentIndex = index;
            //                     setState(() {});
            //       }),
            //             ),
            //           )),
            //     ),
            //     // color: Colors.redAccent,
            //     // child: GridView.builder(
            //     //   shrinkWrap: true,
            //     //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     //         // crossAxisSpacing: defaultPadding,
            //     //         // mainAxisSpacing: defaultPadding,
            //     //         crossAxisCount: openScreens.length == 0 ?  1 : openScreens.length,
            //     //         childAspectRatio: 1.5
            //     //     ), itemBuilder: (context,index) =>GestureDetector(
            //     //   onTap: (){
            //     //     currentIndex = index;
            //     //     setState(() {});
            //     //   },
            //     //       child: Container(
            //     //   color: Colors.grey,
            //     //   child: Padding(
            //     //       padding: const EdgeInsets.all(6.0),
            //     //       child: Text('${openScreens[index].title}'),
            //     //   ),
            //     // ),
            //     //     )),
            //   ),
            // )
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
                        setState(() {
                          currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          var activeIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                          DefaultTabController.of(context).animateTo(activeIndex);
                        });


                      }else{
                        setState(() {
                          openScreens.add(menus[index]);
                          currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                        });

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
                        child: Text('${menus[index].title}',
                          style: header2Dash,),
                      ),
                    ),
                  )
              )
          ),
        );
  }
}
