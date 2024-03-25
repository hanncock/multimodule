import 'package:flutter/material.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/responsive.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(Responsive.isDesktop(context))
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding*0.6),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: primaryColor
                ),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.transparent,
                      child: DrawerHeader(
                        child: Icon(Icons.title),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        print('welcome');
                      },
                      horizontalTitleGap: 0.0,
                      leading: Icon(Icons.home,color: Colors.white,),
                      title: Text('Home',
                          style: header2Dash
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        print('welcome');
                      },
                      horizontalTitleGap: 0.0,
                      leading: Icon(Icons.settings,color: Colors.white,),
                      title: Text('Dashboard',style: header2Dash,),
                    )
                  ],
                ),
              ),
            ),
          ),
        // Expanded(
        //   flex: 5,
        //   child: Dashboard(),
        //   // child: Column(
        //   //   children: [
        //   //     Container(
        //   //       decoration: BoxDecoration(
        //   //         borderRadius: BorderRadius.circular(10),
        //   //         color: Colors.grey[200],
        //   //       ),
        //   //       height: 60,
        //   //     ),
        //   //     Container(
        //   //       color: bgColor,
        //   //     ),
        //   //   ],
        //   // ),
        //
        // )
      ],
    );




    // return Scaffold(
    //   body: SafeArea(
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         if(Responsive.isDesktop(context))
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(defaultPadding*0.6),
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: primaryColor
    //               ),
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     // color: Colors.transparent,
    //                     child: DrawerHeader(
    //                       child: Icon(Icons.title),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: (){
    //                       print('welcome');
    //                     },
    //                     horizontalTitleGap: 0.0,
    //                     leading: Icon(Icons.home,color: Colors.white,),
    //                     title: Text('Home',
    //                         style: header2Dash
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: (){
    //                       print('welcome');
    //                     },
    //                     horizontalTitleGap: 0.0,
    //                     leading: Icon(Icons.settings,color: Colors.white,),
    //                     title: Text('Dashboard',style: header2Dash,),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           flex: 5,
    //           child: Dashboard(),
    //           // child: Column(
    //           //   children: [
    //           //     Container(
    //           //       decoration: BoxDecoration(
    //           //         borderRadius: BorderRadius.circular(10),
    //           //         color: Colors.grey[200],
    //           //       ),
    //           //       height: 60,
    //           //     ),
    //           //     Container(
    //           //       color: bgColor,
    //           //     ),
    //           //   ],
    //           // ),
    //
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
