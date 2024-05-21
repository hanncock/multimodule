import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';
import '../../Constants/Theme.dart';
import '../../Constants/calender.dart';

class AddExam extends StatefulWidget {
  final List? dets;
  const AddExam({super.key, this.dets});

  @override
  State<AddExam> createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {

  late var id = widget.dets?[0]['id'];
  late var name = widget.dets?[0]['examName'];
  late var startDate = widget.dets?[0]['startDate'];
  late var endDate = widget.dets?[0]['endDate'];
  late var shrtform = widget.dets?[0]['shrtfrm'];
  late var selgrading = widget.dets?[0]['grading'];
  late var selgradingId = widget.dets?[0]['gradingId'];

  List gradings = [];


  List sbjExmd = [];

  List subjects = [];

  List examSubjects = [];

  getSubjects()async{
    var resu = await auth.getvalues("school/subject/list?companyId=${companyIdInView}");
    setState(() {
      subjects = resu;
    });
  }

  getGrading()async{
    var resu = await auth.getvalues("school/grading/list?companyId=${companyIdInView}");
    setState(() {
      gradings = resu;
    });
  }

  getExamined()async{
    var resu = await auth.getvalues("school/examsubjects/list?examId=${id}");

    setState(() {
      sbjExmd = resu;
    });
    examSubjects.clear();
    for(int i=0; i<resu.length; i++){
      Map examWithSubjects = {
        "id":resu[i]['id'],
        "examId": resu[i]['examId'],
        "subjectId": resu[i]['subjectId']
      };
      examSubjects.add(examWithSubjects);
    }
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    widget.dets!.isEmpty ?print('soke')  :getSubjects();
    widget.dets!.isEmpty ?print('soke')  :getExamined();
    getGrading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Row(
            children: [
              Expanded(child: btns(label: 'Add Exam'))
            ],
          ),
          Divider(thickness: 0.5,),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      forms(
                        widthh: 250,
                          value: name,
                          initVal: name,
                          label: 'Exam Name',
                          hint: "Exam Name",
                          onChanged: (value){
                            setState(() {
                              name = value;
                            });
                          }),
                      forms(
                        widthh: 100,
                          value: shrtform,
                          initVal: shrtform,
                          label: 'Accronym ',
                          hint: "Accronym",
                          onChanged: (value){
                            setState(() {
                              shrtform = value;
                            });
                          }),


                      Calender(
                        widthh: 150,
                          initVal:startDate,
                          label: 'Start Date',
                          onChanged: (value){
                            setState((){
                              startDate = value;
                            });
                          }
                      ),
                      Calender(
                        widthh: 150,
                          initVal:endDate,
                          label: 'End Date',
                          onChanged: (value){
                            setState((){
                              endDate = value;
                            });
                          }
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Grading System',style: boldfont,),
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 0.5)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                  isExpanded:true,
                                  hint: Text('${selgrading ?? ''}',style: boldfont),
                                  items: gradings.map((e) => DropdownMenuItem(
                                      // value:["${e['gradingTitle']}","${e['id']}"],
                                      value:[e],
                                      child: Text('${e['gradingTitle']}',style: boldfont,))).toList(),
                                  onChanged: (val){
                                    setState(() {
                                      var vals = val as List;
                                      selgrading = vals[0]['gradingTitle'];
                                      selgradingId = vals[0]['id'];
                                    });

                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          // Text('${sbjExmd}'),
          SizedBox(height: 10,),
          Divider(),
          (widget.dets.isNull ||  widget.dets!.isEmpty) ?SizedBox() : Container(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount:subjects.length,
                    itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      if(sbjExmd.contains(subjects[index]['subjectName'])){

                      }else{
                        sbjExmd.add(subjects[index]['subjectName']);
                      }
                      setState(() {});
                    },
                    child: Card(
                      child: Row(
                        children: [
                          examSubjects.where((el)=> el['subjectId'] == subjects[index]['id']).isNotEmpty ?InkWell(
                              onTap: ()async{
                                var indfnd = examSubjects.indexWhere((element) => element['subjectId'] == subjects[index]['id']);
                                print(examSubjects[indfnd]);
                                var resu = await auth.delete(examSubjects[indfnd]['id'],"/school/examsubject/del");
                                getExamined();

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(Icons.check_box_outlined,color: Colors.blue,),
                              )):
                          InkWell(
                              onTap: ()async{

                                Map examWithSubjects = {
                                  "id":null,
                                  "examId": id,
                                  "subjectId": subjects[index]['id']
                                };
                                var resu = await auth.saveMany(examWithSubjects, "/api/school/examsubject/add");
                                print(resu);
                                getExamined();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: const Icon(Icons.check_box_outline_blank,color: Colors.black,),
                              )
                          ),
                          SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${subjects[index]['subjectName']}',style: boldfont,),
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btns(label: 'Register Exam',color: Colors.green,onclick: ()async{

                Map data = {
                  "id":id,
                  "examName" : name,
                  "startDate" : startDate,
                  "endDate" : endDate,
                  "shrtfrm" : shrtform,
                  "companyId" : companyIdInView,
                  "gradingId": selgradingId,
                  "grading":selgrading
                };
                // print(data);
                var resu = await auth.saveMany(data,"/api/school/exam/add");
                print(resu);
                if(resu == 'success'){
                  getSubjects();
                  // Navigator.of(context).pop();
                }else{
                  print('none');
                }
              },)
            ],
          ),
        ],
      ),
    );
  }
}
