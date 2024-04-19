import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';

class AddClass extends StatefulWidget {
  final List? dets;
  const AddClass({super.key, this.dets});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {

  late var id = widget.dets?[0]['id'];
  late var name = widget.dets?[0]['className'];
  late var shrtform = widget.dets?[0]['shrtfrm'];
  late var clsscode = widget.dets?[0]['classCode'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: btns(label: 'Setup Class'))
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
                          label: 'Class Name',
                          hint: "Class Name",
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
                      forms(
                          value: clsscode,
                          initVal: clsscode,
                          label: 'Class Code',
                          hint: "Class Code",
                          onChanged: (value){
                            setState(() {
                              clsscode = value;
                            });
                          }),
                      // forms(
                      //     value: endDate,
                      //     initVal: endDate,
                      //     label: 'End Date',
                      //     hint: "End Date",
                      //     onChanged: (value){
                      //       setState(() {
                      //         endDate = value;
                      //       });
                      //     })
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
                  "className" : name,
                  "shrtform" : shrtform,
                  "classCode" : clsscode,
                  "companyId" : companyIdInView
                };
                var resu = await auth.saveMany(data,"/api/classe/add");
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
