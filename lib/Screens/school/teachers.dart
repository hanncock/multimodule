import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_excel/excel.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Screens/school/addteacher.dart';

import '../../Constants/ImportUI.dart';
import '../../Constants/Reusableswidgets/btns.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {

  List students = [];

  getStudents()async{
    var resu = await auth.getvalues("school/teacher/list?companyId=${companyIdInView}");
    setState(() {
      students = resu;
    });
  }

  @override
  void initState(){
    getStudents();
    super.initState();
  }

  editDetails(var detail){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300,vertical: 200),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Text('Editing'),
                      child: detail == null? Card(child: AddTeacher()) : Card(child: AddTeacher(dets: [detail],)),
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
                    hintText: "Input the values",
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
                    child:btns(label:'Teacher',
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
                        // btns(label: 'Print',icona: Icon(Icons.manage_search_sharp),),
                        btns(label: 'More',),
                        Icon(Icons.arrow_drop_down,)
                      ],
                    ),
                    // child: Text(''),
                    // icon: Icon(Icons.open_with_rounded,color: Colors.blue,),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                btns(label:'Import',icona: Icon(Icons.import_export),color: Colors.brown,
                                    onclick:(){
                                      upload(["sirName","names","email","tscNo","idNo","phone","gender","dob","contact1","contact2","maritalStatus","companyId"],
                                          "Import",
                                          context,
                                          "TeacherData",
                                          "/teacher/add"
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

                                    upload(["sirName","names","email","tscNo","idNo","phone","gender","dob","contact1","contact2","maritalStatus","companyId"],
                                        'Download',
                                        context,
                                        "TeacherData",
                                        "/teacher/add"
                                    );
                                  },)

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
        Divider(height: 0.5,color: Colors.black12,),
        students.isEmpty ?  Center(child: Text('We have no data')):Flexible(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(width: .5,color: Colors.grey.shade400)
                  ),
                  child: DataTable(
                    showCheckboxColumn: false,
                      headingRowHeight: 45,
                      dataRowMinHeight: 53,
                      dataRowMaxHeight: 53,
                      dividerThickness: 0.5,
                      border: const TableBorder(verticalInside: BorderSide(width: .05,)),
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
                            Text('TSC No'),
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
                      ],
                      rows:students.map((item){
                        return DataRow(
                            onSelectChanged: (selected){
                              editDetails(item);
                            },
                            cells: [
                          DataCell( Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.brown.withOpacity(0.2),
                                child: Icon(Icons.computer,color: Colors.black12,),
                                // child: clients[index]['logo'] == null ? Text('-'): Image.network(auth.url+'/'+clients[index]['logo']),
                              ),
                              SizedBox(width: 20,),
                              Text('${item['sirName'].toUpperCase()} ${item['names']}.',),
                              // SizedBox(height: 10,),
                            ],
                          ),),
                          DataCell(Text('${item['tscNo']}'),),
                          DataCell(Text('${item['email']}'),),
                          DataCell(Text('${item['idNo']}'),),
                          DataCell(Text('${item['phone']}'),),
                          DataCell(Text('${item['phone']}'),),
                        ]);
                      }).toList()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
