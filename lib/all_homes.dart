import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Constants/Menus.dart';
import 'package:web3/Screens/dashboard.dart';
import 'package:web3/Screens/dms/dmsdash.dart';
import 'package:web3/Screens/school/addStudent.dart';
import 'package:web3/custom_display/keepAlive.dart';
import 'Constants/calender.dart';
import 'Screens/Wrapper.dart';
import 'Screens/communication/Email.dart';
import 'Screens/communication/Messaging.dart';
import 'Screens/crm/crm_menus.dart';
import 'package:web3/Screens/crm/screen%20display.dart';
import 'package:web3/Screens/crm/CrmsMenuList.dart';
import 'Screens/school/school_alldisps.dart';
import 'Screens/settings/settings.dart';

class AllHomes extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const AllHomes({Key? key, required this.sessionStateStream}) : super(key: key);

  @override
  State<AllHomes> createState() => _AllHomesState();
}

var module;
var companyInView ;//= Userdata['allowedCompanies'][0]['companyName'] ?? null;
var companyIdInView ;//= Userdata['allowedCompanies'][0]['id'] ?? null;
class _AllHomesState extends State<AllHomes> with TickerProviderStateMixin {

  // final AllHomes _controller = Get.put(AllHomes());

  late TabController controller;

  late List openScreens = [
    Menus(
        title: 'AllDash',
        widget: allDash(),
        // widget: Messaging(),
        // widget: MyHomePage(),
        // widget: Settings()
        // widget: ScreenDispSchl()
        // widget: AddStudent()
        // widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),)
    ),
  ];


  int currentIndex = 0;

  List allowed = Userdata['allowedCompanies'];
  var settings = Menus(
      title: 'Settings',
      widget: Settings()
  );

  var messaging = Menus(
      title: 'Messaging',
      widget: Messaging()
  );

  var emailing = Menus(
      title: 'Email',
      widget: Emailing()
  );


  List menusListed = [

    Menus(
        icona: Icon(Icons.school,size: 40,),
        title: 'School',
        widget: ScreenDispSchl()
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
    Menus(
      icona: Icon(Icons.people,size: 40,),
      title: 'will del',
      widget: ScreenDisp(allwindows: myMenus, menuwindow: CrmMenuList(crmenus: myMenus[4]),),
    ),
    Menus(
      icona: Icon(Icons.document_scanner,size: 40,),
      title: 'DMS',
      widget: DMS(),
    ),

  ];

  final List menus = [];

  List modulesaccquired = [];
  List modsacq = [];
  List modules = [];

  getCompanyModules()async{
    var resu = await auth.getvalues('settings/companymodule/list?companyId=${companyIdInView}');
    modsacq = resu;
    modulesaccquired.clear();
    for(int i=0; i<resu.length; i++){
      modulesaccquired.add(resu[i]['moduleId']);
    }
    setState(() {});
  }

  getModules()async{
    var resu = await auth.getvalues('settings/module/list');
    setState(() {
      modules = resu;
    });
  }

  fetchmods(){

    for(int i=0; i<modulesaccquired.length; i++){
      var found = modules.indexWhere((element) => element['id'] == modulesaccquired[i]);
      var menutoadd = menusListed.indexWhere((elem) => elem.title == modules[found]['moduName']);
      menus.add(menusListed[menutoadd]);
    }
    setState(() {});
    return menus;
  }

  setCompany()async{

    SharedPreferences user = await SharedPreferences.getInstance();
    var data = user.getString('compData');

    if(data == null){
      setState(() {
        companyInView = Userdata['allowedCompanies'][0]['companyName'];
        companyIdInView = Userdata['allowedCompanies'][0]['id'];
      });
    }else{
      var svdVals = jsonDecode(data);
      var compSvdVals = svdVals;

      setState(() {
        companyInView =svdVals['companyName'];
        companyIdInView = svdVals['companyId'];
      });
    }




  }


  Future _calculation = Future.delayed(
    const Duration(seconds: 1),
        () => 'soke'
  );
  @override
  void initState() {
    super.initState();
    // sess = widget.sessionStateStream;
    controller = TabController(
      length: openScreens.length,
      vsync: this,
      // initialIndex: tab_index,
    );
    setCompany().whenComplete((){
      getCompanyModules();
      getModules().whenComplete((){
        fetchmods();});
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: DefaultTabController(
        length: openScreens.length,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height -100 ,
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
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
                          dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color:  Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black54,
                            isScrollable:true,
                            tabs: List.generate(
                              growable:true,
                              openScreens.length, (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              // child: Text('${openScreens[index].title}',style: TextStyle(color: Colors.white),),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${openScreens[index].title}',style: header2Dash,),
                                  // Text('${companyInView}',style: header2Dash,),
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
                          child: Row(children: [
                            btns(label: 'More',icona: Icon(Icons.arrow_drop_up_outlined))
                          ]),

                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PopupMenuButton(
                                        child: btns(label: 'Switch Company',icona: Icon(Icons.switch_access_shortcut_add),),
                                        itemBuilder: (BuildContext context){
                                          return allowed.map((e){
                                            return  PopupMenuItem(child: InkWell(
                                                onTap: ()async{
                                                  Map compData = {
                                                    "companyName":e['companyName'],
                                                    "companyId":e['id'],
                                                  };
                                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                                  pref.setString("compData", jsonEncode(compData));
                                                  setCompany();
                                                  openScreens.clear();
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (_) =>
                                                          Wrapper(sessionStateStream: widget
                                                              .sessionStateStream,)));
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Text('${e['companyName']}'),
                                                    ),
                                                  ],
                                                )));
                                          }).toList();
                                        }
                                      ),
                                      SizedBox(height: 10),
                                      btns(label:'Messaging',icona: Icon(Icons.sms,size: 14,),
                                          onclick: (){
                                            if(openScreens.contains(messaging)){
                                              setState(() {
                                                controller = TabController(
                                                  length: openScreens.length,
                                                  vsync: this,
                                                  // initialIndex: tab_index,
                                                );
                                                currentIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                                var activeIndex = openScreens.indexWhere((element) => messaging.title == element.title);
                                                // DefaultTabController.of(context).animateTo(activeIndex);
                                                controller.animateTo(activeIndex);
                                                module = messaging.title;
                                              });


                                            }else{
                                              setState(() {
                                                openScreens.add(messaging);
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
                                      SizedBox(height: 10),
                                      btns(label:'Email',icona: Icon(Icons.email,size: 14,),
                                        onclick: (){
                                          if(openScreens.contains(emailing)){
                                            setState(() {
                                              controller = TabController(
                                                length: openScreens.length,
                                                vsync: this,
                                                // initialIndex: tab_index,
                                              );
                                              currentIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              var activeIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              // DefaultTabController.of(context).animateTo(activeIndex);
                                              controller.animateTo(currentIndex);
                                              module = emailing.title;
                                            });
                                          }else{
                                            controller = TabController(
                                              length: openScreens.length,
                                              vsync: this,
                                              // initialIndex: tab_index,
                                            );
                                            setState(() {
                                              openScreens.add(emailing);

                                              currentIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              print(currentIndex);
                                              var activeIndex = openScreens.indexWhere((element) => emailing.title == element.title);
                                              controller.animateTo(activeIndex);
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      btns(label: '${Userdata['firstName']}',
                                        icona: Icon(Icons.settings,size: 14,),
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
                                      SizedBox(height: 10),
                                      btns(label:'Logout',icona: Icon(Icons.logout,size: 14,),color: Colors.red,
                                        onclick: (){
                                          clearlogs();
                                          Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(builder: (context) => Wrapper(sessionStateStream: widget.sessionStateStream,)), (
                                              route) => false);
                                        },
                                      ),
                                      SizedBox(height: 10),

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
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: _calculation,
          builder: (context,snapshot){
        return Container(
            child:GridView.builder(
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
                      currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                      module = menus[index].title;
                      setState(() {});
                      DefaultTabController.of(context).animateTo(currentIndex);
                    }else{
                      openScreens.add(menus[index]);
                      currentIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                      setState(() {});
                      DefaultTabController.of(context).animateTo(currentIndex);
                      // var activeIndex = openScreens.indexWhere((element) => menus[index].title == element.title);
                      // DefaultTabController.of(context).animateTo(activeIndex - 1);

                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
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
        );
      }),
    );

  }

}
