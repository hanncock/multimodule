import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/Screens/Wrapper.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';
import '../../Constants/calender.dart';

class ScholarSession extends StatefulWidget {
  final List? dets;
  const ScholarSession({super.key, this.dets});

  @override
  State<ScholarSession> createState() => _ScholarSessionState();
}

class _ScholarSessionState extends State<ScholarSession> {

  List sessions = [];

  late var id = widget.dets?[0]['id'];
  late var label = widget.dets?[0]['label'];
  late var startDate = widget.dets?[0]['startDate'];
  late var endDate = widget.dets?[0]['endDate'];
  // late var endDate = widget.dets?[0]['endDate'];
  // late var shrtform = widget.dets?[0]['shrtfrm'];

  getSession()async{
    var resu = await auth.getvalues("school/academicsession/list?companyId=${companyIdInView}");
    setState(() {
      sessions = resu;
    });
    print(resu);
  }


  @override
  void initState(){
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: btns(label: 'Add Scholar Session'))
            ],
          ),
          Divider(thickness: 0.5,),
          Row(
            children: [
              Row(
                children: [
                  forms(
                      value: label,
                      initVal: label,
                      label: 'Session Title',
                      hint: "Session Title",
                      onChanged: (value){
                        setState(() {
                          label = value;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btns(label: 'Add Session',color: Colors.green,onclick: ()async{

                    Map data = {
                      "id":id,
                      "label" : label,
                      "startDate" : startDate,
                      "endDate" : endDate,
                      "companyId" : companyIdInView
                    };
                    var resu = await auth.saveMany(data,"/api/school/academicsession/add");
                    print(resu);
                    if(resu == 'success'){
                      // Navigator.of(context).pop();
                    }else{
                      print('none');
                    }
                  },)
                ],
              ),
            ],
          ),
          Divider(color: Colors.black12,height: 0.5,),
          SizedBox(height: 5,),
          sessions.isEmpty ? Text(''):Container(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                    itemCount:sessions.length,
                    itemBuilder: (context, index){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade200
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${sessions[index]['label']}',style: boldfont,),
                          ),
                          Row(
                            children: [
                              Text('From:'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${sessions[index]['startDate']}'),
                              ),
                              SizedBox(width: 100,),
                              Text('To:'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${sessions[index]['endDate']}'),
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )
          // Text('${widget.custDetails}'),


        ],
      ),
    );
  }
}
