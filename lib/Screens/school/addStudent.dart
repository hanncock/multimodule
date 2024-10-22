import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/Constants/calender.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';

class AddStudent extends StatefulWidget {
  final List? dets;
  const AddStudent({super.key, this.dets});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  late var id = widget.dets?[0]['id'];
  late var firstName = widget.dets?[0]['firstName'];
  late var othernames = widget.dets?[0]['othernames'];
  late var admissionNo = widget.dets?[0]['admissionNo'].toString();
  late var idNo = widget.dets?[0]['idNo'].toString();
  late var phone = widget.dets?[0]['phone'].toString();
  late var gender = widget.dets?[0]['gender'];
  late var email = widget.dets?[0]['email'];
  late var dob = widget.dets?[0]['dob'];
  late var classe = widget.dets?[0]['class'];
  late var stream = widget.dets?[0]['stream'];

  late Map dets = {
    "id":id,
    "firstName":firstName,

  };
  // late var firstName = wid


  TextEditingController _dateControler = TextEditingController();

  DateTime? _selectedDate;

  var overlay = OverlayPortalController();
  void _handleDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _selectDates() async{
    await showWebDatePicker(context: context,
        initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Student Information',style:boldfont),
              ),
            ],
          ),
          Divider(thickness: 0.5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        forms(
                            value: "firstName",
                            initVal: firstName ?? '',
                            label: 'First Name',
                            hint: "First Name",
                            onChanged: (value){
                              setState(() {
                                firstName = value;
                              });

                              print("here is the fname $firstName");
                            }),
                        forms(
                            value: "othernames",
                            initVal: othernames,
                            label: 'Other Names',
                            hint: "Other Names",
                            onChanged: (value){
                              setState(() {
                                othernames = value;
                              });
                            }),
                        forms(
                            value: admissionNo,
                            initVal: admissionNo,
                            label: 'Admission/ Reg No',
                            hint: "Admission / Reg No",
                            onChanged: (value){
                              setState(() {
                                admissionNo = value;
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
                        Calender(
                          initVal:dob,
                          label: 'D.O.B',
                          onChanged: (value){
                           setState((){
                             dob = value;
                           });
                            // print('here is the value');
                            // print(value);
                          }
                        ),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            dropdwn(label: 'Gender', values: ['MALE','FEMALE'],

                              onChanged: (String? value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                              selectedval: gender,
                            )
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
                ),
                SizedBox(width: 30,),
                Container(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          btns(label: 'Create Student',color: Colors.green,onclick: ()async{

                            Map data = {
                              "id":id,
                              "firstName" : firstName,
                              "othernames" : othernames,
                              "admissionNo" : admissionNo,
                              "idNo" : idNo,
                              "phone" : phone,
                              "gender" :gender,
                              "email" : email,
                              "dob" : dob,
                              "companyId" : companyIdInView,
                              "class":classe,
                              "stream":stream

                            };

                            print(data);
                            var resu = await auth.saveMany(data,"/api/school/student/add");
                            print(resu);
                            if(resu == 'success'){
                              Navigator.of(context).pop();
                            }else{
                              print('none');
                            }
                          },)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Divider(color: Colors.black12,height: 0.5,),
          SizedBox(height: 20,),
          id == null ?SizedBox() :Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Parent/Guardian Information',style:boldfont),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        forms(
                            value: dob,
                            initVal: dob,
                            label: 'Name',
                            hint: "Name of parent/ Guardian",
                            onChanged: (value){
                              setState(() {
                                dob = value;
                              });
                            }),
                        SizedBox(height: 20,),

                        forms(
                            value: dob,
                            initVal: dob,
                            label: 'Relation to Student.',
                            hint: "mai@mail.com",
                            onChanged: (value){
                              setState(() {
                                dob = value;
                              });
                            }),
                      ],
                    ),
                   Column(
                     children: [
                       forms(
                           value: dob,
                           initVal: dob,
                           label: 'ID No.',
                           hint: "Id/Passport No.",
                           onChanged: (value){
                             setState(() {
                               dob = value;
                             });
                           }),
                       SizedBox(height: 20,),

                       forms(
                           value: dob,
                           initVal: dob,
                           label: 'Email.',
                           hint: "mai@mail.com",
                           onChanged: (value){
                             setState(() {
                               dob = value;
                             });
                           }),
                     ],
                   ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        forms(
                            value: dob,
                            initVal: dob,
                            label: 'Conatact 1.',
                            hint: "mai@mail.com",
                            onChanged: (value){
                              setState(() {
                                dob = value;
                              });
                            }),
                        SizedBox(height: 20,),

                        forms(
                            value: dob,
                            initVal: dob,
                            label: 'Contact 2.',
                            hint: "mai@mail.com",
                            onChanged: (value){
                              setState(() {
                                dob = value;
                              });
                            }),
                      ],
                    ),

                    btns(
                      icona: Icon(Icons.add,size: 14,),
                      label: 'Add Details',
                      onclick: ()async{

                        // var resu = await auth.  saveMany(de,"/school/student/add");
                        // print('details');
                      },
                    )
                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: 30,),
          // Text('${widget.custDetails}'),


        ],
      ),
    );
  }
}
