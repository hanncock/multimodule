import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
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
  List selectedExam = [];
  List subjects = [];
  var selExam;
  List classes = [];
  var selcls;
  List streams = [];
  var selStrm;
  List students = [];

  List results = [];

  List fndResults = [];

  // late List subjts = selectedExam[0]['subjectsToExm'].split(",") ?? [];

  // List subjects;


  getexams()async{
    var resu = await auth.getvalues("school/exam/list?companyId=${companyIdInView}");
    setState(() {
      exams = resu;
    });
  }

  getExamined(examId)async{
    var resu = await auth.getvalues("school/examsubjects/list?examId=${examId}");

    setState(() {
      subjects = resu;
    });
    // examSubjects.clear();
    // for(int i=0; i<resu.length; i++){
    //   Map examWithSubjects = {
    //     "id":resu[i]['id'],
    //     "examId": resu[i]['examId'],
    //     "subjectId": resu[i]['subjectId']
    //   };
    //   examSubjects.add(examWithSubjects);
    // }
    setState(() {});
  }

  List vals = [];


  getclasses()async{
    var resu = await auth.getvalues("school/classe/list?companyId=${companyIdInView}");
    setState(() {
      classes = resu;
    });
    print(resu);
  }
  getStreams()async{
    var resu = await auth.getvalues("school/stream/list?companyId=${companyIdInView}");
    setState(() {
      streams = resu;
    });
  }

  getStudents()async{
    var endpoint = "school/student/list?companyId=${companyIdInView}";
    if(selcls != null){
      endpoint = endpoint+"&class=${selcls}";
      setState(() {});
    }
    if(selStrm != null){
      endpoint = endpoint+"&stream=${selStrm.toString()}";
      setState(() {});
    }
    var resu = await auth.getvalues(endpoint);
    print(resu);
    if(resu.length > 0){
      students = resu;
    }else{
      students.clear();

    }
    setState(() {});
  }

  getResults()async{
    var endpoint = "school/examresult/list?examId=${selectedExam[0]['id']}&classe=${selcls}";
    var resu = await auth.getvalues(endpoint);
    setState(() {
      fndResults = resu;
    });
  }



  @override
  void initState(){
    super.initState();
    getexams();
    getclasses();
    getStreams();
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
                            hint: selectedExam.isEmpty ?Text('') :Text('${selectedExam[0]['examName'] ?? ''}',style: boldfont),
                            items: exams.map((e) => DropdownMenuItem(
                                // value:["${e['examName']}","${e['id']}"],
                                value:[e],
                                child: Text('${e['examName']}',style: boldfont,))).toList(),
                            onChanged: (val){
                              setState(() {
                                selectedExam.clear();
                                selectedExam = val as List;
                                getExamined(selectedExam[0]['id']);
                                // getResults();

                                // var vals = val as List;
                                // selExam = vals[0].toString() ;
                                // selectedExam
                                // projoId = vals[1] ;
                                // loading = true;
                              });
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
                              });
                              // getStudents().whenComplete((){
                              //   getResults();
                              // });
                              // setState(() {
                              //
                              // });
                              getResults().whenComplete((){
                                 getStudents();
                              });
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
                            hint: Text('${selStrm ?? ''}',style: boldfont),
                            items: streams.map((e) => DropdownMenuItem(
                                value:["${e['streamName']}","${e['id']}"],
                                child: Text('${e['streamName']}',style: boldfont,))).toList(),
                            onChanged: (val){
                              setState(() {
                                var vals = val as List;
                                selStrm = vals[0].toString() ;
                              });
                              getStudents();
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
          students.isEmpty ? Text('select class') :Container(
            child: Column(
              children: [
                Row(
                  children: [
                    DataTable(columns: [
                      DataColumn(label: Text('#')),
                      DataColumn(label: Text('Names'))
                    ],
                        rows:students.map((item){
                          return DataRow(
                              cells: [
                                DataCell(Text('${item['admissionNo']}',style: boldfont,)),
                                DataCell(Text('${item['firstName']} ${item['othernames']}',style: boldfont,)),
                              ]
                          );}).toList()
                    ),
                    DataTable(
                      columnSpacing: 0,
                                  columns: List.generate(subjects.length, (colName) => DataColumn(label: Text('${subjects[colName]['subjectCode']}'))),
                        rows: students.map((item){
                          return DataRow(
                          cells: List.generate(
                            subjects.length,
                                (ind) => DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 0.1)
                                      ),
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                            hintText: 'Input Marks',
                                            hintStyle: TextStyle(fontSize: 12)
                                          ),
                                          initialValue: fndResults.isEmpty? 'no values' : '${
                                              fndResults.indexWhere((element) => element['subjectId'] == subjects[ind]['subjectId'] && element['studentId'] == item['id']) < 0 ? '0':
                                              fndResults[fndResults.indexWhere((element) => element['subjectId'] == subjects[ind]['subjectId'] && element['studentId'] == item['id'])]['results']
                                          }',
                                          onChanged: (val){
                                            var indfnd = fndResults.indexWhere((element) => element['subjectId'] == subjects[ind]['subjectId'] && element['studentId'] == item['id']);
                                            // print(indfnd);
                                            print(fndResults[indfnd]['results']);
                                            Map insertval = {
                                              "id":fndResults[indfnd]['id'] ?? null ,
                                              "studentName" : "${item['firstName']} ${item['othernames']}",
                                              "studentId":item['id'],
                                              "studentAdm": item['admissionNo'],
                                              "examId":selectedExam[0]['id'],
                                              "subjectId":subjects[ind]['subjectId'],
                                              "subjName":subjects[ind]['subjectName'],
                                              "results":val,
                                              "classe":selcls,
                                              "stream":fndResults[indfnd]['stream'] ?? null,
                                              "examName":selectedExam[0]['examName'],
                                              "year":DateTime.now().year
                                            };
                                            if(results.where((element) => element['subjectId'] == subjects[ind]['subjectId'] && element['studentAdm'] == item['admissionNo']).isNotEmpty){
                                              var indx = results.indexWhere((element) => element['subjectId'] == subjects[ind]['subjectId'] && element['studentAdm'] == item['admissionNo']);
                                                  results[indx] = insertval;
                                            }else{
                                              results.add(insertval);
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                              // Text('${ind}'),
                            ),
                          ));
                        }).toList()
                    ),
                  ],
                ),
                btns(label: 'Save Results',
                  onclick: ()async{
                  // print(results);
                  var resu = await auth.saveMany(results, "/api/school/examresult/add");
                  print(resu);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}