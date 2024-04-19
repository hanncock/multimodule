import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Constants/Reusableswidgets/btns.dart';
import '../../../Constants/Reusableswidgets/dropdown.dart';
import '../../../Constants/Reusableswidgets/textfield.dart';
import '../../../Constants/Theme.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class AddProjects extends StatefulWidget {
  final List? Listproject;
  const AddProjects({Key? key,this.Listproject}) : super(key: key);

  @override
  State<AddProjects> createState() => _AddProjectsState();
}

class _AddProjectsState extends State<AddProjects> {

  late DateTime selectedDate = DateTime.now();
  late TextEditingController _controller;


  Future<void> selectDateModal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        // firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      print(picked);
      setState(() {
        selectedDate = picked;
      });
      print(selectedDate);
    }
  }

  late var id = widget.Listproject?[0]['id'];
  late var projectName = widget.Listproject?[0]['projectName'];
  late var projDescription = widget.Listproject?[0]['projDescription'];
  late var personInCharge = widget.Listproject?[0]['personInCharge'];
  late var inchargeMail = widget.Listproject?[0]['inchargeMail'];
  late var inchargeContact = widget.Listproject?[0]['inchargeContact'];
  late var startDate = widget.Listproject?[0]['startDate'];
  late var endDate = widget.Listproject?[0]['endDate'];
  late var projectStatus = widget.Listproject?[0]['projectStatus'];
  late var designation = widget.Listproject?[0]['designation'];


  @override
  void initState(){
    super.initState();
    _controller =
        TextEditingController(text: selectedDate.toString().split(' ')[0]);
  }

  @override
  Widget build(BuildContext context) {
    final textFieldKey = GlobalKey();
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          children: [
            Row(
              children: [
                Expanded(child: btns(label: 'Add Project'))
                // Text('Add Customer'),
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    forms(value: projectName,
                      initVal: projectName,
                      label: 'Project Name',widthh: 400,hint: 'project name', onChanged: (String value) {
                      setState(() {
                        projectName = value;
                      });
                    },)
                  ],
                ),
                Container(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column(
                    //   children: [
                    //     forms(value: startDate,
                    //       initVal: startDate,
                    //       label: 'Start Date',hint: 'Start Date', onChanged: (String value) {
                    //       setState(() {
                    //         startDate = value;
                    //       });
                    //     },)
                    //   ],
                    // ),
                    Row(
                      children: [
                        Text('Start Date',style: boldfont,),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1,color: Colors.black12)
                          ),
                          width: 150,
                          height: 43,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  key: textFieldKey,
                                  controller: _controller,
                                  readOnly: true,
                                  onTap: () async {
                                    final pickedDate = await showWebDatePicker(

                                      context: textFieldKey.currentContext!,
                                      initialDate: selectedDate,
                                      firstDate: DateTime.now().subtract(const Duration(days: 7)),
                                      lastDate: DateTime.now().add(const Duration(days: 14000)),
                                      width: 300,
                                      //withoutActionButtons: true,
                                      weekendDaysColor: Colors.red,
                                    );
                                    if (pickedDate != null) {
                                      print(pickedDate);
                                      // selectedDate = pickedDate;
                                      _controller =
                                          TextEditingController(text: pickedDate.toString().split(' ')[0]);
                                      setState(() {

                                      });
                                    }
                                  },
                                ),
                              ),
                              InkWell(

                                  child: Icon(Icons.calendar_month,color: Colors.black,))
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     InkWell(
                    //       onTap: ()async {
                    //         final DateTime? picked = await showDatePicker(
                    //             context: textFieldKey.currentContext!,
                    //             initialDate: selectedDate,
                    //             firstDate: DateTime(2015, 8),
                    //             // firstDate: DateTime.now(),
                    //             lastDate: DateTime(2101));
                    //         if (picked != null) {
                    //           print(picked);
                    //           setState(() {
                    //             selectedDate = picked;
                    //           });
                    //           print(selectedDate);
                    //         }
                    //       },
                    //       child: forms(
                    //         key: textFieldKey,
                    //         value: endDate,
                    //         initVal: endDate,
                    //         label: 'End Date', hint: 'End Date', onChanged: (String value) {
                    //         setState(() {
                    //           endDate = value;
                    //         });
                    //       },),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
                SizedBox(width: 30,),

                Column(
                  children: [
                    forms(value: projDescription,
                      initVal: projDescription,
                      linecnt: 8,
                      label: 'Project Description', hint: 'Details about the project ', onChanged: (String value) {
                      setState(() {
                        projDescription = value;
                      });
                    },)
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    dropdwn(label: 'Project Status', values: ['Active','In Progress','Suspended','Pending','Expired','Completed'],

                      onChanged: (String? value) {
                        setState(() {
                          projectStatus = value;
                        });
                      },
                      selectedval: projectStatus,)
                  ],
                ),


              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  children: [
                    forms(value: personInCharge,
                      initVal: personInCharge,
                      label: 'Person In Charge',widthh: 400,hint: 'name', onChanged: (String value) {
                      setState(() {
                        personInCharge = value;
                      });
                    },)
                  ],
                ),
                SizedBox(width: 30,),
                Column(
                  children: [
                    forms(value: designation,
                      initVal: designation,
                      label: 'Designation', hint: 'Designation', onChanged: (String value) {
                      setState(() {
                        designation = value;
                      });
                    },)
                  ],
                ),
                SizedBox(width: 30,),

                Column(
                  children: [
                    forms(value: inchargeMail,
                      initVal: inchargeMail,
                      label: 'Email', hint: 'mail@example.com', onChanged: (String value) {
                      setState(() {
                        inchargeMail = value;
                      });
                    },)
                  ],
                ),
                Column(
                  children: [
                    forms(value: inchargeContact,
                      initVal: inchargeContact,
                      label: 'Phone Number', hint: '+000-000-000-000', onChanged: (String value) {
                      setState(() {
                        inchargeContact = value;
                      });
                    },)
                  ],
                ),
              ],
            ),
            SizedBox(height: 30,),
            Divider(color: Colors.black12,height: 0.5,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btns(label: 'Create Project',
                  onclick: ()async{
                  var resu = await auth.createProj(id, projectName, projDescription, personInCharge, inchargeMail, inchargeContact, startDate, endDate, projectStatus,designation);

                  if(resu == 'success'){
                   Navigator.of(context).pop();
                  }

                  print(resu);
                },)
              ],
            )
          ],
        ),
      ),
    );
  }
}
