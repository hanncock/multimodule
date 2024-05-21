import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web3/Screens/school/addStudent.dart';
import 'package:web3/Screens/school/admittoclass.dart';
import '../../Constants/ImportUI.dart';
import '../../Constants/Reusableswidgets/btns.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {

  List students = [];

  getStudents()async{
    var resu = await auth.getvalues("school/student/list?companyId=${companyIdInView}");
    setState(() {
      students = resu;
    });
  }

  @override
  void initState(){
    getStudents();
    super.initState();
  }

  List selecteds = [];

  editDetails(var detail){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 80),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Text('Editing'),
                      child: detail == null? Card(child: AddStudent()) : Card(child: AddStudent(dets: [detail],)),
                      // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                    ),
                  ),
                );
              });
        });
  }

  admitorMove(var detail){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 80),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: selecteds.isEmpty ? null : AdmitOrMove(dets: detail,),
                      // child: Text('Editing'),
                      // child: detail == null? Card(child: AddStudent()) : Card(child: AddStudent(dets: [detail],)),
                      // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                    ),
                  ),
                );
              });
        });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                // height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1,color: Colors.black12)
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Student Name",
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),

            IconButton(
                onPressed: (){
                  getStudents();
                }, icon: Icon(Icons.refresh,color: Colors.green,)
            ),
            // Icon(Icons.refresh,color: Colors.green,),
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:btns(label:'Student',
                      color: Colors.green,
                      icona: Icon(Icons.add,size: 14,),
                      onclick: (){
                        editDetails(null);
                        // upload(["clientName","clientEmail"],'Download');
                      },)),
                Container(
                  width: 120,
                  // height: 68,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          width: 1,
                          color: Colors.grey.shade200
                      ),
                    ),
                    // child: Text('More'),
                    child: Row(
                      children: [
                        btns(label: 'More',),
                        Icon(Icons.arrow_drop_down,)
                      ],
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                btns(label:'Import',icona: Icon(Icons.import_export),color: Colors.brown,
                                    onclick:(){
                                      upload(["firstName","othernames","email","admissionNo","idNo","phone","gender","dob","companyId"],
                                          "Import",
                                          context,
                                          "StudentData",
                                          "/school/student/add"
                                      );
                                    }),
                                SizedBox(height: 8),
                                btns(label:'Export CSV',icona: Icon(Icons.comment_sharp),color: Colors.amber,onclick: (){
                                  // downloadCSV('test');
                                },),
                                SizedBox(height: 8),
                                btns(label:'Export PDF',icona: Icon(Icons.picture_as_pdf_outlined),color: Colors.purple,),
                                SizedBox(height: 8),
                                btns(label:'Print',icona: Icon(Icons.print),),
                                SizedBox(height: 8),
                                btns(label:'Download Import Sheet',
                                  color: Colors.cyan,
                                  icona: Icon(Icons.download),
                                  onclick: (){
                                    upload(["firstName","othernames","email","admissionNo","idNo","phone","gender","dob","companyId"],
                                        'Download',
                                        context,
                                        "StudentData",
                                        "/school/student/add"
                                    );
                                  },),
                                SizedBox(height: 8),
                                btns(label:'Admit to Class',icona: Icon(Icons.add_moderator),
                                  onclick: (){
                                  selecteds.isEmpty ? null : admitorMove(selecteds);
                                  },
                                ),
                                SizedBox(height: 8),
                                btns(label:'Move to Next Class',icona: Icon(Icons.receipt_long),),
                                SizedBox(height: 8),
                                btns(label:'Delete',color: Colors.red,icona: Icon(Icons.delete),
                                onclick: ()async{
                                  print('deleting');
                                  List ids = [];
                                  for(int i=0; i<selecteds.length; i++){
                                    ids.add(selecteds[i]['id']);
                                  }
                                  print(ids);
                                  var resu = await auth.delete(ids, "/school/student/del");
                                  print(resu);
                                  if(resu == 'success'){
                                    getStudents();
                                    selecteds.clear();
                                  }
                                },
                                ),
                                SizedBox(height: 8),

                              ],
                            )
                        ),
                      ];
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        // InputDecorator(
        //   decoration: InputDecoration(
        //     labelText: 'COMPANY DETAILS',
        //     labelStyle: TextStyle(fontWeight: FontWeight.bold),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //
        //     ),
        //   ),
        // ),
        Divider(height: 0.5,color: Colors.black12,),
        students.isEmpty ?  Center(child: Text('We have no data')):Flexible(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                border: Border.all(width: .5,color: Colors.grey.shade400)
              ),
              child: Row(
                children: [
                  // DataTable(
                  //   // headingRowColor: MaterialStateProperty.all(Colors.cyan.withOpacity(0.5)),
                  //   headingRowColor: MaterialStateProperty.all(Colors.white70),
                  //   headingRowHeight: 45,
                  //   dataRowMinHeight: 53,
                  //   dataRowMaxHeight: 53,
                  //   dividerThickness: 0.5,
                  //   border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                  //
                  //   columns: [
                  //     DataColumn(label: Row(
                  //       children: [
                  //         Icon(Icons.person,color: Colors.black,),
                  //         Text('Name'),
                  //       ],
                  //     ))
                  //   ],
                  //   rows: students.map((item){
                  //     return DataRow(
                  //         cells: [
                  //       DataCell(Row(
                  //         children: [
                  //           CircleAvatar(
                  //             backgroundColor:Colors.blue.withOpacity(0.1),
                  //             child: Text('${item['firstName'][0].toUpperCase()} ${(item['othernames'][0]).toUpperCase()}',
                  //               style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),),
                  //             radius: 15,
                  //           ),
                  //           SizedBox(width: 10,),
                  //           Text('${item['firstName']} ${item['othernames']}',
                  //               // style: boldfont,
                  //               // style: TextStyle(fontSize: 13,fontFamily: GoogleFonts.poppins().fontFamily,fontWeight: FontWeight.bold)
                  //           ),
                  //         ],
                  //       ))
                  //     ]);
                  //   }).toList(),
                  // ),
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          showCheckboxColumn: false,
                          headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                          headingRowHeight: 45,
                          dataRowMinHeight: 53,
                          dataRowMaxHeight: 53,
                          dividerThickness: 0.5,
                          // border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                          columns: [
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.person,color: Colors.black,),
                                Text('Name'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.app_registration,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Reg No'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.mail,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Email'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.credit_card,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('ID No.'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.phone,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Phone'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.generating_tokens,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Gender'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.class_,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Class'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.straighten_outlined,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Stream'),
                              ],
                            )),
                          ],
                          rows: students.map((item){
                            return DataRow(
                                onSelectChanged: (selected){
                                  if(selecteds.contains(item)){
                                    // selecteds.add(item);
                                    editDetails(item);
                                  }else{
                                    selecteds.add(item);

                                  }
                                  setState(() {});

                                },
                                cells: [
                                  DataCell(Row(
                                    children: [
                                      selecteds.isEmpty ? SizedBox():
                                          selecteds.contains(item) ? InkWell(
                                              onTap:(){
                                                selecteds.remove(item);
                                                setState(() {});
                                              },
                                              child: Icon(Icons.check_box_outlined,color: Colors.blue,)):
                                              Icon(Icons.check_box_outline_blank,color: Colors.black12,),
                                      SizedBox(width: 20,),
                                      CircleAvatar(
                                        backgroundColor:Colors.blue.withOpacity(0.1),
                                        // child: Text('${item['firstName'][0].toUpperCase()} ${(item['othernames'] == null ? '' : item['othernames'][0]).toUpperCase()}',
                                        //   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),),
                                        radius: 15,
                                      ),
                                      SizedBox(width: 10,),
                                      Text('${item['firstName']} ${item['othernames']}',
                                        // style: boldfont,
                                        // style: TextStyle(fontSize: 13,fontFamily: GoogleFonts.poppins().fontFamily,fontWeight: FontWeight.bold)
                                      ),
                                    ],
                                  )),
                                  DataCell(Text('${item['admissionNo']}')),
                                  DataCell(Text('${item['email']}',style: TextStyle(color: Colors.blue,),)),
                                  DataCell(Container(
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green.withOpacity(0.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text('${item['idNo']}'),
                                      ))),
                                  DataCell(Text('${item['phone']}')),
                                  DataCell(Text('${item['gender']}',textAlign: TextAlign.start)),
                                  DataCell(Text('${item['class'] ?? ''}')),
                                  DataCell(Text('${item['stream'] ?? ''} ')),
                            ]);
                          }).toList(),
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
