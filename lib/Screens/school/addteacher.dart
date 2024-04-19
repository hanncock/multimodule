import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';

class AddTeacher extends StatefulWidget {
  final List? dets;
  const AddTeacher({super.key, this.dets});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {

  late var id = widget.dets?[0]['id'];
  late var sirName = widget.dets?[0]['sirName'];
  late var names = widget.dets?[0]['names'];
  late var tscNo = widget.dets?[0]['tscNo'];
  late var idNo = widget.dets?[0]['idNo'].toString();
  late var phone = widget.dets?[0]['phone'].toString();
  late var gender = widget.dets?[0]['gender'];
  late var email = widget.dets?[0]['email'];
  late var designation = widget.dets?[0]['designation'];
  late var dob = widget.dets?[0]['dob'];
  late var maritalStatus = widget.dets?[0]['maritalStatus'];
  // late var firstName = wid

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
                          value: sirName,
                          initVal: sirName,
                          label: 'Sir Name',
                          hint: "Sir Name",
                          onChanged: (value){
                            setState(() {
                              sirName = value;
                            });
                          }),
                      forms(
                          value: names,
                          initVal: names,
                          label: 'Other Names',
                          hint: "Other Names",
                          onChanged: (value){
                            setState(() {
                              names = value;
                            });
                          }),
                      forms(
                          value: tscNo,
                          initVal: tscNo,
                          label: 'TscNo',
                          hint: "TscNo",
                          onChanged: (value){
                            setState(() {
                              tscNo = value;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      forms(
                          value: email,
                          initVal: email,
                          label: 'Email',
                          hint: "mail@mail.com ",
                          onChanged: (value){
                            setState(() {
                              email = value;
                            });
                          }),
                      forms(
                          value: idNo,
                          initVal: idNo,
                          label: 'ID No.',
                          hint: "ID/Passport No.",
                          onChanged: (value){
                            setState(() {
                              idNo = value;
                            });
                          }),
                      forms(
                          value: phone,
                          initVal: phone,
                          label: 'Phone No',
                          hint: "Phone No",
                          onChanged: (value){
                            setState(() {
                              phone = value;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      forms(
                          value: dob,
                          initVal: dob,
                          label: 'D.O.B',
                          hint: "date of birth",
                          onChanged: (value){
                            setState(() {
                              dob = value;
                            });
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          dropdwn(label: 'Marital Status', values: ['Single','Married'],

                            onChanged: (String? value) {
                              setState(() {
                                maritalStatus = value;
                              });
                            },
                            selectedval: maritalStatus,)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          dropdwn(label: 'Gender', values: ['MALE','FEMALE'],

                            onChanged: (String? value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            selectedval: gender,)
                        ],
                      ),

                    ],
                  )
                ],
              ),
              SizedBox(width: 30,),
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.5)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.camera,color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Select Photo'),
                      )
                    ],
                  ),
                ),
              )
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
                  "sirName" : sirName,
                  "names" : names,
                  "tscNo" : tscNo,
                  "idNo" : idNo,
                  "phone" : phone,
                  "gender" :gender,
                  "email" : email,
                  "dob" : dob,
                  "maritalStatus" : maritalStatus,
                  "designation" : designation,
                  "companyId" : companyIdInView

                };
                var resu = await auth.saveMany(data,"/api/teacher/add");
                if(resu == 'success'){
                  Navigator.of(context).pop();
                }else{
                  print('none');
                }
                print('Creating User');
              },)
            ],
          )

        ],
      ),
    );
  }
}
