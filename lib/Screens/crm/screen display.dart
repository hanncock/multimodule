import 'package:flutter/material.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/crm/customers/customers.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/Screens/homeScreen.dart';

import '../../custom_display/keepAlive.dart';
import 'Leads/Leads.dart';
import 'crm_menus.dart';
import 'customers/importcustomers.dart';


late List openScreenstitles = ['Dashboard'];
late final openScreensWidgets = <dynamic>[ImportCust()];
late TabController controller;


class ScreenDisp extends StatefulWidget {
  final List allwindows;
  final Widget menuwindow;
  const ScreenDisp({Key? key,required this.allwindows, required this.menuwindow}) : super(key: key);

  @override
  State<ScreenDisp> createState() => _ScreenDispState();
}

class _ScreenDispState extends State<ScreenDisp> with TickerProviderStateMixin{


  int activetab = 0;
  int active = 0;




  @override
  void initState() {
    super.initState();
    // sess = widget.sessionStateStream;
    controller = TabController(
      length: widget.allwindows.length,
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
    return Column(
      children: [
        DefaultTabController(

            length: openScreenstitles.length,
            initialIndex: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(' Module Name',style: modname,),
                    ),
                    Expanded(
                      child: Card(
                        child: TabBar(
                          indicatorColor: Colors.white,
                          isScrollable:true,
                          tabs: List.generate(
                            growable:true,
                              openScreenstitles.length, (index) => Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text('${openScreenstitles[index]}',style: TextStyle(color: Theme.of(context).primaryColor),),
                              ))
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width:200,
                      decoration: const BoxDecoration(
                        // color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(0, 0),
                              blurRadius: 0,
                              spreadRadius: 0
                            )
                          ]
                      ),
                      height:MediaQuery.of(context).size.height * 0.88,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  var menuList = widget.allwindows[index];
                                  return InkWell(
                                      onTap: (){
                                        if(openScreenstitles.contains(menuList.title)){
                                          var activeIndex = openScreenstitles.indexOf(menuList.title);
                                          DefaultTabController.of(context).animateTo(activeIndex);
                                        }else{
                                          setState(() {
                                            openScreenstitles.add(menuList.title);
                                            openScreensWidgets.add(menuList.widget);
                                            activetab = index;
                                          });
                                          var activeIndex = openScreenstitles.indexOf(menuList.title);
                                          DefaultTabController.of(context).animateTo(activeIndex - 1);

                                        }
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: activetab == index ? Theme.of(context).primaryColor : Colors.blueAccent.shade200,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: CrmMenuList(crmenus: menuList)

                                      )
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 10);
                                },
                                itemCount: widget.allwindows.length),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Card(
                        shadowColor: Colors.red,
                        child: Container(
                          width:MediaQuery.of(context).size.width - 250,
                          height:MediaQuery.of(context).size.height * 0.873,
                          child: TabBarView(
                              children: List.generate(
                                openScreensWidgets.length,
                                    (index) => KeepPageAlive(
                                  child: openScreensWidgets[index],
                                ),
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
        )

      ],
    );
  }
}
