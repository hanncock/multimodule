import 'package:flutter/material.dart';

import '../../../Constants/Reusableswidgets/btns.dart';
import '../../../Constants/Reusableswidgets/dropdown.dart';
import '../../../Constants/Reusableswidgets/textfield.dart';
import '../../../Constants/Theme.dart';

class AddProjects extends StatefulWidget {
  const AddProjects({Key? key}) : super(key: key);

  @override
  State<AddProjects> createState() => _AddProjectsState();
}

class _AddProjectsState extends State<AddProjects> {

  var id, projectName, projDescription;
  var personInCharge, inchargeMail, inchargeContact;
  var startDate, endDate;
  var projectStatus;
  var designation;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(

        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  forms(value: projectName, label: 'Project Name',widthh: 400,hint: 'project name', onChanged: (String value) {
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
                  Column(
                    children: [
                      forms(value: startDate, label: 'Start Date',hint: 'Start Date', onChanged: (String value) {
                        setState(() {
                          startDate = value;
                        });
                      },)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      forms(value: endDate, label: 'End Date', hint: 'End Date', onChanged: (String value) {
                        setState(() {
                          endDate = value;
                        });
                      },)
                    ],
                  ),
                ],
              ),
              SizedBox(width: 30,),

              Column(
                children: [
                  forms(value: projDescription, label: 'Project Description', hint: 'Details about the project ', onChanged: (String value) {
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
                  forms(value: personInCharge, label: 'Person In Charge',widthh: 400,hint: 'name', onChanged: (String value) {
                    setState(() {
                      personInCharge = value;
                    });
                  },)
                ],
              ),
              SizedBox(width: 30,),
              Column(
                children: [
                  forms(value: designation, label: 'Designation', hint: 'Designation', onChanged: (String value) {
                    setState(() {
                      designation = value;
                    });
                  },)
                ],
              ),
              SizedBox(width: 30,),

              Column(
                children: [
                  forms(value: inchargeMail, label: 'Email', hint: 'mail@example.com', onChanged: (String value) {
                    setState(() {
                      inchargeMail = value;
                    });
                  },)
                ],
              ),
              Column(
                children: [
                  forms(value: inchargeContact, label: 'Phone Number', hint: '+000-000-000-000', onChanged: (String value) {
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
                print(resu);
              },)
            ],
          )
        ],
      ),
    );
  }
}
