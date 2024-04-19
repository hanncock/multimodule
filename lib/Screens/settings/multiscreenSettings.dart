import 'package:flutter/material.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/Screens/settings/CompaniesUI.dart';
import 'package:web3/Screens/settings/SettingsDash.dart';
import 'package:web3/Screens/settings/addCompany.dart';
import 'package:web3/Screens/settings/settings.dart';
import '../../custom_display/keepAlive.dart';

class SettingScreenDisp extends StatefulWidget {
  final List allwindows;
  final Widget menuwindow;
  const SettingScreenDisp({Key? key,required this.allwindows, required this.menuwindow}) : super(key: key);

  @override
  State<SettingScreenDisp> createState() => _ScreenDispState();
}

class _ScreenDispState extends State<SettingScreenDisp> with TickerProviderStateMixin{



  List openScreenstitles = ['Dashboard'];
  final openScreensWidgets = <dynamic>[Companies()];
  late TabController controller2;
  int activetab = 0;
  int active = 0;




  @override
  void initState() {
    super.initState();
    controller2 = TabController(length: widget.allwindows.length, vsync: this,);
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
                      // child: Text('${module}',style: modname,),
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width:200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border(
                          right: BorderSide( //                   <--- right side
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
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
                                          controller2 = TabController(length: widget.allwindows.length, vsync: this);
                                          DefaultTabController.of(context).animateTo(activeIndex);
                                          // controller2.animateTo(activeIndex);
                                          print('contains');
                                        }else{
                                          openScreenstitles.add(menuList.title);
                                          openScreensWidgets.add(menuList.widget);
                                          print('added');
                                          // activetab = index;
                                          //
                                          controller2 = TabController(length: widget.allwindows.length, vsync: this);
                                          var activeIndex = openScreenstitles.indexOf(menuList.title);
                                          DefaultTabController.of(context).animateTo(activeIndex -1);
                                        }
                                        setState(() {});

                                      },
                                      child: Container(
                                          decoration: BoxDecoration(

                                              borderRadius: BorderRadius.circular(10),
                                              color: activetab == index ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.white
                                          ),
                                          // child: widget.tocall == null ? CrmMenuList(crmenus: menuList) : widget.tocall
                                          child: SettingMenus(allmenus: menuList,)

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

  @override
  void dispose(){
    controller2.dispose();
    super.dispose();
  }

}
