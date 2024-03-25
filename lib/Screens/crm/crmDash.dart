import 'package:flutter/material.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/crm/screen%20display.dart';

import 'CrmsMenuList.dart';
import 'crmCards.dart';
import 'crm_menus.dart';

class CRMDash extends StatefulWidget {
  const CRMDash({Key? key}) : super(key: key);

  @override
  State<CRMDash> createState() => _CRMDashState();
}

class _CRMDashState extends State<CRMDash> {

  int active = 0;

  List men = [
    'soke',1234,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              // Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Text('Module Name',style: modname,),
              //   ),
              // ),
              // Card(
              //   child: Container(
              //
              //     width: MediaQuery.of(context).size.width,
              //     height: 35,
              //     child: Wrap(
              //       children: List.generate(
              //           openScreens.length, (index) => Padding(
              //         padding: const EdgeInsets.only(left: 6.0),
              //         child: FilterChip(
              //             backgroundColor: Colors.blueAccent,
              //             selectedColor: Colors.red,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(20),
              //
              //             ),
              //             label: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text('${openScreens[index].title}',style: TextStyle(color: Colors.white),),
              //             ),
              //             onSelected: (val){
              //               currentIndex = index;
              //               setState(() {});
              //             }),
              //       )),
              //     ),
              //
              //   ),
              // )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [

                  IntrinsicHeight(
                      child: VerticalDivider(
                        width: 10,
                      )
                  ),
                  Container(
                    child: Text('All widgests appear here'),
                  )
                ],
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: 200,
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: ListView.separated(
              //           shrinkWrap: true,
              //             itemBuilder: (context, index){
              //             var menuList = myMenus[index];
              //               return InkWell(
              //                 onTap: (){
              //                   setState(() {
              //                     active = index;
              //                   });
              //                 },
              //                   child: Container(
              //                       decoration: BoxDecoration(
              //                           color: active == index ? Theme.of(context).primaryColor : Colors.black12,
              //                           borderRadius: BorderRadius.circular(10)
              //                       ),
              //                       child: CrmMenuList(crmenus: menuList)
              //                   )
              //               );
              //             },
              //             separatorBuilder: (context, index) {
              //               return SizedBox(height: 10);
              //             },
              //             itemCount: myMenus.length),
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Column(
              //           children: [
              //             Text(' i appear here'),
              //
              //             Container(
              //                 color:Colors.red,
              //               child: GridView.builder(
              //                   physics: NeverScrollableScrollPhysics(),
              //                   shrinkWrap: true,
              //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                       crossAxisSpacing: defaultPadding,
              //                       mainAxisSpacing: defaultPadding,
              //                       crossAxisCount: 4,
              //                       childAspectRatio: 1.5
              //                   ),
              //                   itemCount: mycards.length,
              //                   itemBuilder: (context, index) =>
              //                      CrmCardsUI(crmcards: mycards[index])
              //
              //                   ),
              //             ),
              //             Container(
              //               child: ListView.builder(
              //                 shrinkWrap: true,
              //                 itemBuilder: (context, index){
              //                 return Text('soke');
              //               },
              //                 itemCount: 10,
              //
              //               ),
              //
              //             )
              //             // Text('extra details')
              //           ],
              //         ),
              //       ),
              //     ),
              //
              //
              //   ],
              // ),
              Row(
                children: [
                  // ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
