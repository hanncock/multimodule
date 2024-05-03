import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';
import '../../Constants/calender.dart';

class AddSubject extends StatefulWidget {
  final List? dets;
  const AddSubject({super.key, this.dets});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {

  late var id = widget.dets?[0]['id'];
  late var name = widget.dets?[0]['subjectName'];
  late var shrtform = widget.dets?[0]['subjectCode'];
  // late var endDate = widget.dets?[0]['endDate'];
  // late var shrtform = widget.dets?[0]['shrtfrm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: btns(label: 'Add Subject'))
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
                          label: 'Subject Name',
                          hint: "Subject Name",
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
              btns(label: 'Register Subject',color: Colors.green,onclick: ()async{

                Map data = {
                  "id":id,
                  "subjectName" : name,
                  "subjectCode" : shrtform,
                  // "endDate" : endDate,
                  // "shrtfrm" : shrtform,
                  "companyId" : companyIdInView
                };
                var resu = await auth.saveMany(data,"/api/school/subject/add");
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
