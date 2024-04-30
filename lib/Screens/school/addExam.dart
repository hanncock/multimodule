import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: btns(label: 'Add Teacher'))
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
                            // print('here is the value');
                            // print(value);
                          }
                      ),
                      Calender(
                          initVal:endDate,
                          label: 'End Date',
                          onChanged: (value){
                            setState((){
                              endDate = value;
                            });
                            // print('here is the value');
                            // print(value);
                          }
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),
          Divider(color: Colors.black12,height: 0.5,),
          SizedBox(height: 30,),
          // Text('${widget.custDetails}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btns(label: 'Add Teacher',color: Colors.green,onclick: ()async{

                Map data = {
                  "id":id,
                  "examName" : name,
                  "startDate" : startDate,
                  "endDate" : endDate,
                  "shrtfrm" : shrtform,
                  "companyId" : companyIdInView
                };
                var resu = await auth.saveMany(data,"/api/school/exam/add");
                if(resu == 'success'){
                  Navigator.of(context).pop();
                }else{
                  print('none');
                }
              },)
            ],
          )

        ],
      ),
    );
  }
}
