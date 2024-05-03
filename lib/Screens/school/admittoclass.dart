import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';

import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class AdmitOrMove extends StatefulWidget {
  final List? dets;
  const AdmitOrMove({super.key,this.dets});

  @override
  State<AdmitOrMove> createState() => _AdmitOrMoveState();
}

class _AdmitOrMoveState extends State<AdmitOrMove> {

  List classes = [];
  var selcls;
  List streams = [];
  var selStrm;

  getClasses()async{
    var resu = await auth.getvalues("school/classe/list?companyId=${companyIdInView}");
    setState(() {
      classes = resu;
    });
  }


  getStreams()async{
    var resu = await auth.getvalues("school/stream/list?companyId=${companyIdInView}");
    setState(() {
      streams = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getClasses();
    getStreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Exam'),
                  Container(
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          isExpanded:true,
                          hint: Text('${selcls ?? ''}',style: boldfont),
                          items: classes.map((e) => DropdownMenuItem(
                              value:["${e['className']}","${e['id']}"],
                              child: Text('${e['className']}',style: boldfont,))).toList(),
                          onChanged: (val){
                            setState(() {
                              var vals = val as List;
                              selcls = vals[0].toString() ;
                              // projoId = vals[1] ;
                              // loading = true;
                            });
                            // projectColumns();
                            // combined.clear();
                            // client().whenComplete((){
                            //   for(int i=0; i<projoPrams.length; i++){
                            //     var idtocheck = projoPrams[i]['id'];
                            //     Map<String, dynamic> grouping = {};
                            //     combined.add(grouping[idtocheck] = clients.where((element) => element['leadId'] == idtocheck).toList());
                            //   }
                            //   setState(() {
                            //     loading = false;
                            //   });
                            //   print(combined);
                            // });
                            // print(clients);
                          }
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Stream'),
                  Container(
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          isExpanded:true,
                          hint: Text('${selStrm ?? ''}',style: boldfont),
                          items: streams.map((e) => DropdownMenuItem(
                              value:["${e['streamName']}","${e['id']}"],
                              child: Text('${e['streamName']}',style: boldfont,))).toList(),
                          onChanged: (val){
                            setState(() {
                              var vals = val as List;
                              selStrm = vals[0].toString() ;
                              setState(() {

                              });

                              // projoId = vals[1] ;
                              // loading = true;
                            });
                            // projectColumns();
                            // combined.clear();
                            // client().whenComplete((){
                            //   for(int i=0; i<projoPrams.length; i++){
                            //     var idtocheck = projoPrams[i]['id'];
                            //     Map<String, dynamic> grouping = {};
                            //     combined.add(grouping[idtocheck] = clients.where((element) => element['leadId'] == idtocheck).toList());
                            //   }
                            //   setState(() {
                            //     loading = false;
                            //   });
                            //   print(combined);
                            // });
                            // print(clients);
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text('here are the values to use'),
          Container(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: widget.dets!.length,
                itemBuilder: (context, index){
              return Text('${widget.dets![index]}');
            }),
          ),
          btns(label: 'Admit',
          onclick: ()async{

            for(int i=0; i<widget.dets!.length; i++){
              // final user = jsonDecode(widget.dets![i]) as Map<dynamic, dynamic>;
              // user["class"] = selcls;
              // user["stream"] = selStrm;

              var rs = widget.dets![i];
              rs['class'] = selcls;
              rs['stream'] = selStrm;
              setState(() {});
              // print(rs);
              // Map<String, dynamic> jsonMap = json.decode(widget.dets![i]);
              // print(widget.dets![i].runtimeType);
              // jsonMap['class'] = selcls; // Example of adding a value
              // jsonMap['stream'] = selStrm;
              // widget.dets?.removeWhere((element) => element == widget.dets![i]);
              // String updatedJsonString = json.encode(jsonMap);
              // widget.dets?.add(updatedJsonString);
              // widget.dets![i].add[{"class":selStrm}];
            }
            // print(widget.dets);
            var resu = await auth.saveMany(widget.dets,"/api/school/student/add");
            print(resu);
            if(resu == 'success'){
              Navigator.of(context).pop();
            }else{
              print('none');
            }
          },
          )
        ],
      ),
    );
  }
}


