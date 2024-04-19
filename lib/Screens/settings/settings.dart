import 'package:flutter/material.dart';
import 'package:web3/Screens/settings/CompaniesUI.dart';
import 'package:web3/Screens/settings/modulesetup.dart';
import 'package:web3/Services/User.dart';
import '../../Constants/Theme.dart';
import '../crm/Leads/Leads.dart';
import 'Users.dart';
import 'multiscreenSettings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SettingScreenDisp(
        allwindows: SettingsMenuList,
        menuwindow: SettingMenus(allmenus: SettingsMenuList[4],),)
    );
  }
}

late final SettingsMenuList = [
  AllMenus(
    title: 'Profile',
    widget: Leads(),
    icona: Icon(Icons.person_2_outlined,color: Colors.black,),
  ),

  AllMenus(
    title: 'Users',
    widget: Users(),
    icona: Icon(Icons.people,color: Colors.black,),
  ),
  AllMenus(
    title: 'Companies',
    widget: Companies(),
    icona: Icon(Icons.factory,color: Colors.black,),
  ),
  AllMenus(
    title: 'Mail Setup',
    widget: Leads(),
    icona: Icon(Icons.email_outlined,color: Colors.black,),
  ),
  AllMenus(
    title: 'Messaging Setup',
    widget: Leads(),
    icona: Icon(Icons.message,color: Colors.black,),
  ),
  AllMenus(
    title: 'Module Setup',
    widget: ModuleSetup(),
    icona: Icon(Icons.message,color: Colors.black,),
  ),
];


class AllMenus{

  String title;
  Widget widget;
  final Icon icona;
  // final bool active;

  AllMenus({
    required this.title,
    required this.widget,
    required this.icona,
    // required this.active
  });


}

class SettingMenus extends StatelessWidget {
  final AllMenus allmenus;
  const SettingMenus({Key? key, required this.allmenus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          allmenus.icona ,
          SizedBox(width: 20,),
          Flexible(child: Text(allmenus.title,style: boldfont,softWrap: true,))
        ],
      ),
    );
  }
}



