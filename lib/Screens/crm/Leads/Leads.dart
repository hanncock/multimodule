import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/dropdown.dart';

import '../../../Constants/Reusableswidgets/textfield.dart';
import '../../../Constants/Theme.dart';

class Leads extends StatefulWidget {
  const Leads({super.key});

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {

  late List projects =[] ;
  var projoInView;
  var projoId;
  final _textNameController = TextEditingController();

  // List  projoPrams = ["Potemtial","Reached Out","In Comm","Meeting Set","Presentation","Deal & Agreemnet","Deal Sent"];
  List  projoPrams = [];
  var colName;
  List cols = [];

  List toSend = [];

  project()async{
    var resu = await auth.getProjects();
    setState(() {
      projects = resu;
    });
  }

  projectColumns()async{
    var resu = await auth.getRequests('projectcolumn/list?projectId=${projoId}');
    setState(() {
      projoPrams = resu;
    });
  }

  upload(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.all(120.0),
                  child: Container(
                      child: Card(child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Column Name',style: header1,),
                                        ),
                                        Container(
                                            width: 400,
                                            height:40,
                                            child: TextFormField(
                                              onFieldSubmitted: (value) {
                                                setState((){cols.add(colName);});
                                                _textNameController.clear();
                                              },
                                              controller: _textNameController,
                                              onChanged: (_textNameController){
                                                setState((){
                                                  colName = _textNameController;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                  // labelText: widget.label,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      // color: Colors.green
                                                    ),

                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.circular(10)

                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 0.5, color: Colors.black),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  // hintText: '${widget.hint}',
                                                  hintStyle: boldfont
                                              ),
                                            )
                                        ),
                                        SizedBox(width: 5,),
                                        btns(label: '',icona: Icon(Icons.add),color: Colors.green,


                                          onclick: (){
                                          setState((){cols.add(colName);});
                                          _textNameController.clear();
                                        },),
                                      ],
                                    )
                                  ]
                              ),
                              Divider(thickness: 0.5,),
                              cols.isEmpty ? SizedBox(): Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 200,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          cols.length,(index)=>Expanded(
                                            child: Container(
                                              color: Colors.greenAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text('${cols[index]}'),
                                                  ),
                                                  InkWell(
                                                      onTap: (){
                                                        setState((){
                                                          // cols.removeAt(cols[index]);
                                                          cols.removeWhere((element) => element == cols[index]);
                                                        });
                                                      },
                                                      child: Icon(Icons.close,color: Colors.red,))
                                                ],
                                              )),
                                          ),
                                        ),
                                      )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        btns(label: 'Save',onclick: ()async{
                                          for(int i=0; i<cols.length; i++){
                                            Map<String, dynamic> mapval = {};
                                            // toSend.add([])
                                            mapval[ "projColName"] = cols[i];
                                            mapval['projectId'] = projoId;
                                            toSend.add(mapval);
                                          }
                                          print(toSend);
                                          var resu = await auth.saveMany(toSend,'/api/projectcolumn/add');
                                          if(resu == 'success'){
                                            Navigator.of(context).pop();
                                            projectColumns();
                                          }

                                        })

                                      ],
                                    )
                                  ],
                                ),
                              ),


                            ],
                          )
                      )
                      )
                  ),
                );
              });
        });
  }

  getColumns()async{
    // var resu = await auth.
  }


  @override
  void initState(){
    project();
    // super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          projects.isEmpty ? Text('--') : Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select Project',style: boldfont),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: 300,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              isExpanded:true,
                              hint: Text('${projoInView ?? ''}',style: boldfont),
                              items: projects.map((e) => DropdownMenuItem(
                                  value:["${e['projectName']}","${e['id']}"],
                                  child: Text('${e['projectName']}',style: boldfont,))).toList(),
                              onChanged: (val){
                                setState(() {
                                  var vals = val as List;
                                  projoInView = vals[0].toString() ;
                                  projoId = vals[1] ;
                                });
                                projectColumns();
                              }

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              projoInView == null ? Text('') :Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${projoInView ?? ''}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      color: Colors.orange
                    ),),
                ),
              ))
            ],
          ),

          projoInView==null ? Text(''):Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  
                  children: List.generate(
                      growable: true,
                      projoPrams.length, (index) => Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / projoPrams.length,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / projoPrams.length,
                                color: Colors.greenAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${projoPrams[index]['projColName']}'),
                                ),
                              ),
                              Container(
                                // height: 30,
                                // margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    forms(
                                      // label: 'Enter to add to column',
                                      value: 'test',
                                      onChanged: (String value) {  },),
                                    Icon(Icons.add,color: Colors.blue,)

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  // children: [
                  //
                  // ],
                ),
              ),
              btns(label: 'Add',onclick: (){upload();},)
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

