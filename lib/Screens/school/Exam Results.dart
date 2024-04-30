import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class ExamResults extends StatefulWidget {
  const ExamResults({super.key});

  @override
  State<ExamResults> createState() => _ExamResultsState();
}

class _ExamResultsState extends State<ExamResults> {


  List exams = [];
  List classes = [];
  var selExam;
  var selcls;


  getexams()async{
    // var resu = await auth.getvalues("school/exam/list?companyId=${companyIdInView}");
    var resu = await auth.getvalues("school/exam/list?companyId=2204");
    setState(() {
      exams = resu;
    });
  }

  getStudents()async{
    // var resu = await auth.getvalues("school/classe/list?companyId=${companyIdInView}");
    var resu = await auth.getvalues("school/classe/list?companyId=2204");
    setState(() {
      classes = resu;
    });
    print(resu);
  }

  @override
  void initState(){
    super.initState();
    getexams();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Exam'),
                    Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                            isExpanded:true,
                            hint: Text('${selExam ?? ''}',style: boldfont),
                            items: exams.map((e) => DropdownMenuItem(
                                value:["${e['examName']}","${e['id']}"],
                                child: Text('${e['examName']}',style: boldfont,))).toList(),
                            onChanged: (val){
                              setState(() {
                                var vals = val as List;
                                selExam = vals[0].toString() ;
                                // projoId = vals[1] ;
                                // loading = true;
                              });
                              // projectColumns();
                              // combined.clear();
                              // client().whenComplete((){
                              //   for(int i=0; i<projoPrams.length; i++){
                              //     var idtocheck = projoPrams[i]['id'];
                              //     Map<String, dynamic> grouping = {};
                              //     combined.add(grouping[idtocheck] = clients.where((element) => element['leadId'] == idtocheck).toList());
                              //   }
                              //   setState(() {
                              //     loading = false;
                              //   });
                              //   print(combined);
                              // });
                              // print(clients);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Class'),
                    Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.5)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                            isExpanded:true,
                            hint: Text('${selcls ?? ''}',style: boldfont),
                            items: classes.map((e) => DropdownMenuItem(
                                value:["${e['className']}","${e['id']}"],
                                child: Text('${e['className']}',style: boldfont,))).toList(),
                            onChanged: (val){
                              setState(() {
                                var vals = val as List;
                                selcls = vals[0].toString() ;
                                // projoId = vals[1] ;
                                // loading = true;
                              });
                              // projectColumns();
                              // combined.clear();
                              // client().whenComplete((){
                              //   for(int i=0; i<projoPrams.length; i++){
                              //     var idtocheck = projoPrams[i]['id'];
                              //     Map<String, dynamic> grouping = {};
                              //     combined.add(grouping[idtocheck] = clients.where((element) => element['leadId'] == idtocheck).toList());
                              //   }
                              //   setState(() {
                              //     loading = false;
                              //   });
                              //   print(combined);
                              // });
                              // print(clients);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Stream'),
                    Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.5)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                            isExpanded:true,
                            hint: Text('${selcls ?? ''}',style: boldfont),
                            items: classes.map((e) => DropdownMenuItem(
                                value:["${e['className']}","${e['id']}"],
                                child: Text('${e['className']}',style: boldfont,))).toList(),
                            onChanged: (val){
                              setState(() {
                                var vals = val as List;
                                selcls = vals[0].toString() ;
                                // projoId = vals[1] ;
                                // loading = true;
                              });
                              // projectColumns();
                              // combined.clear();
                              // client().whenComplete((){
                              //   for(int i=0; i<projoPrams.length; i++){
                              //     var idtocheck = projoPrams[i]['id'];
                              //     Map<String, dynamic> grouping = {};
                              //     combined.add(grouping[idtocheck] = clients.where((element) => element['leadId'] == idtocheck).toList());
                              //   }
                              //   setState(() {
                              //     loading = false;
                              //   });
                              //   print(combined);
                              // });
                              // print(clients);
                            }
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
          Divider(height: 0.5,),
        ],
      ),
    );
  }
}
