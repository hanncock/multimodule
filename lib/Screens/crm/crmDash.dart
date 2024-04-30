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
