import 'package:flutter/material.dart';
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
import '../accounting/chargesSetup.dart';
import 'addStudent.dart';
import 'exams.dart';
import 'feesandcharges.dart';

// List openScreenstitles = ['Dashboard'];
// final openScreensWidgets = <dynamic>[Exams()];
// late TabController controller2;

class ScreenDispSchl extends StatefulWidget {

  const ScreenDispSchl({
    Key? key,
    // required this.allwindows,
    // required this.menuwindow,
    // this.tocall,
  }) : super(key: key);

  @override
  State<ScreenDispSchl> createState() => _ScreenDispState();
}

class _ScreenDispState extends State<ScreenDispSchl>
    with TickerProviderStateMixin {
  late TabController controller2;

  int activetab = 0;
  int active = 0;

  var actv ;

  List openScreenstitles = ['Dashboard'];
  final openScreensWidgets = <dynamic>[ExamResults()];


  late final schlMenuslst = [
    SchlMenus(
        title: 'Dashboard',
        widget: Students(),
        icona: Icon(Icons.home_max,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Students',
        widget: Students(),
        icona: Icon(Icons.safety_divider_sharp,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Teachers',
        widget: Teacher(),
        icona: Icon(Icons.person,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Examinations',
        widget: Exams(),
        icona: Icon(Icons.edit_note_sharp,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Grading System',
        widget: GradingSystem(),
        icona: Icon(Icons.safety_divider_sharp,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Results',
        widget: ExamResults(),
        icona: Icon(Icons.safety_divider_sharp,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Library',
        widget: SizedBox(child: Text('Here'),),
        icona: Icon(Icons.library_books,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Class/Year',
        widget: Classes(),
        icona: Icon(Icons.flight_class,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Stream',
        widget: AddStream(),
        icona: Icon(Icons.view_stream_outlined,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Subjects',
        widget: Subjectc(),
        icona: Icon(Icons.view_stream_outlined,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Fees & Charges',
        widget: ChargesSetup(),
        icona: Icon(Icons.monetization_on_sharp,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Boarding & Residency',
        widget: Subjectc(),
        icona: Icon(Icons.bed,color: Colors.black,)
    ),
    SchlMenus(
        title: 'Scholarly Sessions',
        widget: ScholarSession(),
        icona: Icon(Icons.monetization_on_sharp,color: Colors.black,)
    )
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
    return Container(
      // color: Colors.grey.shade100.withOpacity(0.5),
      color: Colors.white60,
      child: Column(
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
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.1,color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                          // color: Colors.grey
                        ),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                              color:  Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          indicatorColor: Colors.purple,
                          isScrollable: true,
                          tabs: openScreenstitles
                              .map(
                                (title) => Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        var index = openScreenstitles.indexWhere((element) => element  == title);
                                        print(index);
                                        setState(() {
                                          openScreenstitles.removeAt(index);
                                          openScreensWidgets.removeAt(index);
                                          // if(openScreens[index].title == settings.title){
                                          //   currentIndex = openScreens.indexWhere((element) => settings.title == element.title);
                                          //   openScreens.removeAt(currentIndex);
                                          // }else{
                                          //   currentIndex = openScreens.indexWhere((element) => openScreens[index].title == element.title);
                                          //   openScreens.removeAt(currentIndex);
                                          // }
                                        });
                                      },
                                      child: CircleAvatar(
                                          radius: 8,
                                          child: Icon(Icons.close,size: 10,color: Colors.red,)))
                                ],
                              ),
                            ),
                          )
                              .toList(),
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
                                setState(() {
                                  actv = index;
                                });
                                if (openScreenstitles.contains(menuList.title)) {
                                  var activeIndex =
                                  openScreenstitles.indexOf(menuList.title);
                                  DefaultTabController.of(context)!
                                      .animateTo(activeIndex);
                                  controller2.animateTo(activeIndex);
                                } else {
                                  setState(() {
                                    openScreenstitles.add(menuList.title);
                                    openScreensWidgets.add(menuList.widget);
                                    var activeIndex =
                                    openScreenstitles.indexOf(menuList.title);
                                    DefaultTabController.of(context)!
                                        .animateTo(activeIndex - 1);
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    color: actv == index ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.white
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
                            children: openScreensWidgets
                                .map((widget) => KeepPageAlive(child: widget),).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller2.dispose();
    super.dispose();
  }
}
