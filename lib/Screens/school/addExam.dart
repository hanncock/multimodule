import 'package:flutter/material.dart';
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

  List sbjExmd = [];

  List subjects = [];

  List examSubjects = [];

  getSubjects()async{
    var resu = await auth.getvalues("school/subject/list?companyId=${companyIdInView}");
    setState(() {
      subjects = resu;
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
    widget.dets!.isEmpty ?null  :getSubjects();
    widget.dets!.isEmpty ?null  :getExamined();
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
                          initVal:startDate,
                          label: 'Start Date',
                          onChanged: (value){
                            setState((){
                              startDate = value;
                            });
                          }
                      ),
                      Calender(
                          initVal:endDate,
                          label: 'End Date',
                          onChanged: (value){
                            setState((){
                              endDate = value;
                            });
                          }
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
          widget.dets!.isEmpty?SizedBox() : Container(
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
                    child: Row(
                      children: [
                        examSubjects.where((el)=> el['subjectId'] == subjects[index]['id']).isNotEmpty ?InkWell(
                            onTap: ()async{
                              var indfnd = examSubjects.indexWhere((element) => element['subjectId'] == subjects[index]['id']);
                              print(examSubjects[indfnd]);
                              var resu = await auth.delete(examSubjects[indfnd]['id'],"/school/examsubject/del");
                              getExamined();

                            },
                            child: Icon(Icons.check_box_outlined,color: Colors.blue,)):
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
                            child: Icon(Icons.check_box_outline_blank,color: Colors.black,)
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${subjects[index]['subjectName']} ${subjects[index]['id']}'),
                        )
                      ],
                    ),
                  );
                })

              ],
            ),
          ),
          Divider(),
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
                };
                //
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
