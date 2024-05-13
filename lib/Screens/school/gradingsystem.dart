import 'package:flutter/material.dart';
import 'package:flutter_excel/excel.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';

import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class GradingSystem extends StatefulWidget {
  const GradingSystem({super.key});

  @override
  State<GradingSystem> createState() => _GradingSystemState();
}

class _GradingSystemState extends State<GradingSystem> {

  List grading = [];
  List grader = [];
  var points;
  var grade;
  var valuefrom;
  var valueto;


  var gradingTitil;

  getGrading()async{
    var resu = await auth.getvalues("school/grading/list?companyId=${companyIdInView}");
    setState(() {
      grading = resu;
    });
  }

  getSelcted(val)async{
    var resu = await auth.getvalues("school/gradingvalue/list?gradingId=${val}");
    setState(() {grader = resu;});
  }



  editDetails(details){
    showDialog(context: context,
        builder: (BuildContext context){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200,vertical: 200),
        child: Card(
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                forms(
                  initVal: gradingTitil,
                  hint: 'Gradint Title',
                  label: "Grading Title",
                  value: gradingTitil,
                  onChanged: (val){
                    setState((){
                      gradingTitil = val;
                    });
                  },
                ),
                btns(
                  label: 'Save',
                  onclick: ()async{
                    Map insertVals ={
                      "id":null,
                      "companyId":companyIdInView,
                      "gradingTitle":gradingTitil
                    };
                    print(insertVals);
                    var resu = await auth.saveMany(insertVals, "/api/school/grading/add");
                    if(resu == 'success'){
                      Navigator.of(context).pop();
                    }
                  },
                )


              ],
            ),
          ),
        ),
      );
        });
  }

  enterGrading(details){
    showDialog(context: context,
        builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200,vertical: 100),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${details['gradingTitle']}',style: boldfont,),
                  ),
                  Row(
                    children: [
                      forms(
                        initVal: valuefrom,
                        hint: '0 - 100',
                        label: "From",
                        value: valuefrom,
                        onChanged: (val){
                          setState((){
                            valuefrom = val;
                          });
                        },
                      ),
                      forms(
                        initVal: valueto,
                        hint: '0 - 100',
                        label: "to",
                        value: valueto,
                        onChanged: (val){
                          setState((){
                            valueto = val;
                          });
                        },
                      ),
                      forms(
                        initVal: points,
                        hint: 'Points',
                        label: "points",
                        value: points,
                        onChanged: (val){
                          setState((){
                            points = val;
                          });
                        },
                      ),
                      forms(
                        initVal: grade,
                        hint: 'A',
                        label: "Grade",
                        value: grade,
                        onChanged: (val){
                          setState((){
                            grade = val;
                          });
                        },
                      ),
                      btns(
                        label: 'Save Range',
                        onclick: ()async{
                          Map insertVals ={
                            "id":null,
                            "gradingId":details['id'],
                            "grade":grade,
                            "points":points,
                            "valuefrom":valuefrom,
                            "valueto":valueto
                          };
                          print(insertVals);
                          var resu = await auth.saveMany(insertVals, "/api/school/gradingvalue/add");
                          if(resu == 'success'){
                            getSelcted(details['id']);
                            // Navigator.of(context).pop();
                          }
                        },
                      )
                    ],
                  ),
                  Divider(color: Colors.black12,height: 0.1,),
                  SizedBox(height: 10,),
                  Container(
                    width: 400,
                    child: Column(
                      children: [
                        grader.isEmpty ? Text(''):
                        DataTable(
                            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                            columns: [
                              DataColumn(label: Text('Grade')),
                              DataColumn(label: Text('From')),
                              DataColumn(label: Text('To')),
                              DataColumn(label: Text('Points')),
                            ],
                            rows:grader.map((item){
                              return DataRow(cells: [
                                DataCell(Text('${item['grade']}')),
                                DataCell(Text('${item['valuefrom']}')),
                                DataCell(Text('${item['valueto']}')),
                                DataCell(Text('${item['points']}'))
                              ]);
                            }).toList()
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState(){
    super.initState();
    getGrading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btns(
                  label: 'Add Grading',
                  onclick: (){
                    editDetails(null);
                  },
                )
              ],
            ),
            Divider(height: 0.1,color: Colors.black12,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: grading.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      getSelcted(grading[index]['id']).whenComplete((){
                        enterGrading(grading[index]);
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("${grading[index]['gradingTitle']}"),
                      ),
                    ),
                  );
            })
          ],
        ),
      ),
    );
  }
}
