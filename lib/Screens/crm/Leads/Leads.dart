import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/dropdown.dart';
import 'package:web3/Constants/loading.dart';

import '../../../Constants/Reusableswidgets/textfield.dart';
import '../../../Constants/Theme.dart';
import '../customers/addcustomer.dart';

class Leads extends StatefulWidget {
  const Leads({super.key});

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {

  late List projects =[] ;
  late List combined = [];

  var leadId;
  var projoInView;
  var projoId;
  final _textNameController = TextEditingController();

  late List clients = [];

  // List  projoPrams = ["Potemtial","Reached Out","In Comm","Meeting Set","Presentation","Deal & Agreemnet","Deal Sent"];
  List  projoPrams = [];
  var colName;
  List cols = [];

  List toSend = [];

  bool loading = false;
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

  client()async{
    var resu = await auth.getclients(projoId);
    if(resu.length == 0){
      print('empty');
    }else{
      setState(() {clients = resu;});
    }
  }

  editDetails(var detail){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: Text('Editing'),
                    child: detail == null? Card(child: AddCustomer(projectId: projoId,leadId: leadId,)) : Card(child: AddCustomer(custDetails: [detail],)),
                    // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                  ),
                );
              });
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
                                        btns(label: '',
                                          icona: Icon(Icons.add),
                                          color: Colors.green,
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
                                  loading = true;
                                });
                                projectColumns();
                                combined.clear();
                                client().whenComplete((){
                                  for(int i=0; i<projoPrams.length; i++){
                                    var idtocheck = projoPrams[i]['id'];
                                    Map<String, dynamic> grouping = {};
                                    combined.add(grouping[idtocheck] = clients.where((element) => element['leadId'] == idtocheck).toList());
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                  print(combined);
                                });
                                // print(clients);
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
          loading ? LoadingSpinCircle() : Text(''),
          projoInView==null ? Text(''):Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 70,
                      child: btns(label: 'Add',onclick: (){upload();},)),
                ],
              ),
              Row(

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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${projoPrams[index]['projColName']}'),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    leadId = projoPrams[index]['id'];
                                  });
                                  editDetails(null);
                                },
                                child: Container(
                                  // height: 30,
                                  // margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1,color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add,color: Colors.blue,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
              // projoPrams.isEmpty ? Text('loading'): Container(
              //   width: MediaQuery.of(context).size.width - 200,
              //   // color: Colors.brown,
              //   child: DataTable(
              //     // dataRowHeight: 600,
              //     columns: List.generate(projoPrams.length, (index) => DataColumn(label:Text('${projoPrams[index]['projColName']}'), )),
              //     // rows: List.generate(projoPrams.length, (index) => DataRow(cells: [DataCell(Text(''))])),
              //     rows: List.generate(1, (index) => DataRow(
              //         cells:List<DataCell>.generate(
              //             projoPrams.length, (index) => DataCell(
              //           Container(
              //             color: Colors.white,
              //             // width: 400,
              //             // width: (MediaQuery.of(context).size.width - 380) / projoPrams.length,
              //             width: 400,
              //             child: ListView.builder(
              //                 itemCount: combined[index].length,
              //                 itemBuilder: (context, num){
              //                   var dats = combined[index];
              //                   var dat = dats[num];
              //                   return Row(
              //                     children: [
              //                       Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Column(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 Text('${dat['clientName']}',style: boldfont,),
              //                               ],
              //                             ),
              //                             SizedBox(height: 10,),
              //                             Row(
              //                               children: [
              //                                 Icon(Icons.call,color: Colors.green,),
              //                                 Padding(
              //                                   padding: const EdgeInsets.all(8.0),
              //                                   child: Text('${dat['clientPhone']}'),
              //                                 ),
              //                               ],
              //                             ),
              //                             SizedBox(height: 10,),
              //                             Row(
              //                               children: [
              //                                 Icon(Icons.mail,color: Colors.brown,),
              //                                 Padding(
              //                                   padding: const EdgeInsets.all(8.0),
              //                                   child: Text('${dat['clientEmail']}'),
              //                                 ),
              //                               ],
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   );
              //             }),
              //           )
              //             // Text('${
              //             //     combined[index]}')
              //         )
              //         )
              //     )
              //     ),
              //     // rows: [
              //     //   DataRow(cells: [
              //     //     DataCell(Text('soke')),
              //     //     DataCell(Text('soke')),
              //     //     DataCell(Text('soke')),
              //     //     DataCell(Text('soke')),
              //     //     DataCell(Text('soke'))
              //     //   ]
              //     //   )
              //     // ],
              //   ),
              // ),




              clients.isEmpty ? Text('') :Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      growable: true,
                      projoPrams.length, (index){
                    var value = combined[index];
                    return Container(
                      width: MediaQuery.of(context).size.width / projoPrams.length - 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: combined[index].length,
                          itemBuilder: (context,num){
                          var dat = combined[index][num];
                          return Container(
                            width: MediaQuery.of(context).size.width /projoPrams.length -50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.5,color: Colors.black12)
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('${dat['clientName']}',style: boldfont,),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Icon(Icons.call,color: Colors.green,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${dat['clientPhone']}'),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Icon(Icons.mail,color: Colors.brown,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${dat['clientEmail']}'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.more_vert_rounded,color: Colors.black,)
                              ],
                            )
                          );
                      }),
                    );
                  }),
                )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

