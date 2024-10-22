import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web3/Screens/crm/screen%20display.dart';
import 'package:web3/Screens/hrm/Attendance.dart';
import 'package:web3/Screens/hrm/BioUsers.dart';
import 'package:web3/Screens/hrm/getxcontroller.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Theme.dart';
import '../../custom_display/keepAlive.dart';
import '../school/schlMenus.dart';

class HRMDash extends StatefulWidget {
  const HRMDash({super.key});

  @override
  State<HRMDash> createState() => _HRMDashState();
}

class _HRMDashState extends State<HRMDash> with TickerProviderStateMixin {
  late TabController controller2;




  late final schlMenuslst = [
    SchlMenus(
        title: 'Stats & Dash',
        widget: BioUsers(),
        icona: Icon(Icons.people,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Users',
        widget: BioUsers(),
        icona: Icon(Icons.people,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Attendance',
        widget: Attendance(),
        icona: Icon(Icons.pattern,color: Colors.black,)
    ),
  ];



  @override
  Widget build(BuildContext context) {

    TapControllerHrm tapController = Get.put(TapControllerHrm());


    return Container(
        // color: Color.fromRGBO(231, 230, 247,1),
        child: GetBuilder<TapControllerHrm>(
          builder: (tapController) {

            return DefaultTabController(
              // length: openScreenstitles.length,
              length: tapController.openScreenstitlles.length,
              initialIndex: tapController.actvTab,
              // initialIndex: activetab,
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(32, 30, 80,0),
                          color: Color.fromRGBO(32, 30, 80,5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )
                      ),
                      width: 250,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('${companyInView}',style: TextStyle(color: Colors.white),),
                                ),
                                Divider(color: Colors.white,thickness: 1,)

                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              // color: Colors.grey[200],
                              border: Border(
                                right: BorderSide( //                   <--- right side
                                  color: Colors.black12,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.868,
                            child: ListView.builder(
                                itemCount: schlMenuslst.length,
                                itemBuilder: (context, index){
                                  var menuList = schlMenuslst[index];
                                  return InkWell(
                                    onTap: (){
                                      tapController.printList();
                                      if(tapController.openScreenstitlles.contains(menuList.title)){
                                        tapController.switchTo(menuList.title);
                                        DefaultTabController.of(context)!
                                            .animateTo(tapController.actvTab);
                                        controller2.animateTo(tapController.actvTab);
                                      }else{

                                        tapController.addtoList(menuList.title,menuList.widget);

                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                            // color: tapController.actvTab == index ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.white
                                        ),
                                        child: SchlMenuList(schlMenus: schlMenuslst[index],),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                  ),
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width -250,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255,1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: GetBuilder<TapControllerHrm>(
                              builder: (tapController) {
                                return TabBar(
                                  dividerColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                      color:  Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.black54,
                                  indicatorColor: Colors.purple,
                                  isScrollable: true,
                                  // tabs: openScreenstitles
                                  tabs: tapController.openScreenstitlles
                                      .map(
                                        (title) => Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${title}',
                                            style: TextStyle(
                                              // color: Colors.white
                                              // color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          // openScreenstitles.where((element) => element == 'Dashboard').isNotEmpty?
                                          title == 'Dashboard' ? Text('') :InkWell(
                                              onTap: (){
                                                tapController.deleteTab(tapController.actvTab);
                                              },
                                              child: CircleAvatar(
                                                  radius: 8,
                                                  child: Icon(Icons.close,size: 10,color: Colors.red,)))
                                        ],
                                      ),
                                    ),
                                  )
                                      .toList(),
                                );
                              }
                          ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.grey[200]
                            color: Color.fromRGBO(231, 230, 247,1),

                          ),
                          width: MediaQuery.of(context).size.width - 250,
                          height: MediaQuery.of(context).size.height * 0.868,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              // children: openScreensWidgets
                              children: tapController.openScreensWidgetts
                                  .map((widget) => KeepPageAlive(child: widget),).toList(),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            );
          }
        ),
      );
  }
}
