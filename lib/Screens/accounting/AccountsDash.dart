// import 'package:flutter/material.dart';
//
// class AccountsDash extends StatefulWidget {
//   const AccountsDash({super.key});
//
//   @override
//   State<AccountsDash> createState() => _AccountsDashState();
// }
//
// class _AccountsDashState extends State<AccountsDash> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Column(
//                 children: [
//                   Text('Menus')
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3/Screens/accounting/chartofaccnts.dart';
import 'package:web3/Screens/accounting/getxcontroller.dart';
import 'package:web3/Screens/school/Exam%20Results.dart';
import 'package:web3/Screens/school/Subjects.dart';
import 'package:web3/Screens/school/addSubject.dart';
import 'package:web3/Screens/school/addsreams.dart';
import 'package:web3/Screens/school/classes.dart';
import 'package:web3/Screens/school/gradingsystem.dart';
import 'package:web3/Screens/school/schlMenus.dart';
import 'package:web3/Screens/school/scholarsession.dart';
import 'package:web3/Screens/school/students.dart';
import 'package:web3/Screens/school/teachers.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';
import '../../custom_display/keepAlive.dart';
import 'acctsStats.dart';



class AccountsDash extends StatefulWidget {

  const AccountsDash({
    Key? key,
    // required this.allwindows,
    // required this.menuwindow,
    // this.tocall,
  }) : super(key: key);

  @override
  State<AccountsDash> createState() => _ScreenDispState();
}

class _ScreenDispState extends State<AccountsDash> with TickerProviderStateMixin {
  late TabController controller2;


  List openScreenstitles = ['Dashboard'];
  final openScreensWidgets = <dynamic>[AccntStats()];


  late final schlMenuslst = [
    SchlMenus(
        title: 'Dashboard',
        widget: Students(),
        icona: Icon(Icons.home_max,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Chart Of Accounts',
        widget: ChartodAccnts(),
        icona: Icon(Icons.safety_divider_sharp,color: Colors.black,)
    ),
  ];


  @override
  void initState() {
    super.initState();
    // controller2 = TabController(
    //   length: widget.allwindows.length,
    //   vsync: this,
    // );
  }

  @override
  Widget build(BuildContext context) {
    TapController tapController = Get.put(TapController());


    return Container(
      // color: Colors.grey.shade100.withOpacity(0.5),
      color: Colors.white60,
      child: Column(
        children: [
          GetBuilder<TapController>(
            builder: (tapController) {
              return DefaultTabController(
                // length: openScreenstitles.length,
                length: tapController.openScreenstitlles.length,
                initialIndex: tapController.actvTab,
                // initialIndex: activetab,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [

                                  Text(
                                    '${companyInView}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${module ?? ''}',
                                style: modname,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 5,
                            child: GetBuilder<TapController>(
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
                                      padding: const EdgeInsets.all(5.0),
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
                                          title == 'Dashboard' ? Text('') :Column(

                                            children: [
                                              InkWell(
                                                  onTap: (){
                                                    tapController.deleteTab(tapController.actvTab);
                                                  },
                                                  child: Icon(Icons.close,size: 10,color: Colors.red,)),
                                              Text(''),

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      .toList(),
                                );
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
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
                                          color: tapController.actvTab == index ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.white
                                      ),
                                      child: SchlMenuList(schlMenus: schlMenuslst[index],),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey[200]
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
                    ),
                  ],
                ),
              );
            }
          )
        ],
      ),
    );
  }


}
