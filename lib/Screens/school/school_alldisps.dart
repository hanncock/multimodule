import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web3/Screens/school/getxcontroller.dart';
import '../../all_homes.dart';
import '../../custom_display/keepAlive.dart';
import '../accounting/chargesSetup.dart';
import 'Exam Results.dart';
import 'Subjects.dart';
import 'addsreams.dart';
import 'classes.dart';
import 'exams.dart';
import 'gradingsystem.dart';
import 'schlMenus.dart';
import 'scholarsession.dart';
import 'students.dart';
import 'teachers.dart';


class ScreenDispSchl extends StatefulWidget {

  const ScreenDispSchl({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenDispSchl> createState() => _ScreenDispState();
}

class _ScreenDispState extends State<ScreenDispSchl> with TickerProviderStateMixin {
  late TabController controller2;


  late final schlMenuslst = [
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

  }

  @override
  Widget build(BuildContext context) {

    TapControllerSchl tapController = Get.put(TapControllerSchl());

    return Container(
      // color: Colors.grey.shade100.withOpacity(0.5),
      child: GetBuilder<TapControllerSchl>(
          builder: (tapController) {
            return DefaultTabController(
              length: tapController.openScreenstitlles.length,
              initialIndex: tapController.actvTab,
              child: Row(
                children: [
                  Flexible(
                    flex: 1.5.toInt(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.compare,color: Colors.redAccent,),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text('${companyInView}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.black26,thickness: 1,)

                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white10,
                              ),
                              child: ListView.builder(
                                // shrinkWrap: true,
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
                                            // controller2.animateTo(tapController.actvTab);
                                          }else{
                          
                                            tapController.addtoList(menuList.title,menuList.widget);
                          
                                          }
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                          
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                        width: 1, color: Colors.black12)
                                                ),
                                                child: Row(
                                                  children: [
                                                    menuList.icona,
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Text('${menuList.title}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                    ),
                                                  ],
                          
                                                )
                                            )
                                        )
                                    );
                          
                                  })
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width -250,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255,1),
                            borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 5,color: Color.fromRGBO(231, 230, 247,1),)
                        ),
                        child: GetBuilder<TapControllerSchl>(
                            builder: (tapController) {
                              return TabBar(
                                dividerColor: Colors.transparent,
                                indicator: BoxDecoration(
                                    color: Color.fromRGBO(231, 230, 247,5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                labelColor: Colors.black26,
                                unselectedLabelColor: Colors.black,
                                indicatorColor: Colors.purple,
                                isScrollable: true,
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
                              color:  Color.fromRGBO(231, 230, 247,1),
                              // color: Colors.grey[200]
                            ),
                            width: MediaQuery.of(context).size.width - 250,
                            height: MediaQuery.of(context).size.height * 0.868,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: tapController.openScreensWidgetts
                                    .map((widget) => KeepPageAlive(child: widget),)
                                    .toList(),
                              ),
                            ),
                          )
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
