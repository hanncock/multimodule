import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Screens/school/addStudent.dart';

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
    var resu = await auth.getvalues("student/list?companyId=${companyIdInView}");
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
                                      upload(["firstName","othernames","email","admissionNo","idNo","phone","gender","dob","companyId"],
                                          "Import",
                                          context,
                                          "StudentData",
                                          "/student/add"
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
                                        "/student/add"
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                border: Border.all(width: .5,color: Colors.grey.shade400)
              ),
              child: Row(
                children: [
                  DataTable(
                    // headingRowColor: MaterialStateProperty.all(Colors.cyan.withOpacity(0.5)),
                    headingRowColor: MaterialStateProperty.all(Colors.white70),
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
                      ))
                    ],
                    rows: students.map((item){
                      return DataRow(
                          cells: [
                        DataCell(Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:Colors.blue.withOpacity(0.1),
                              child: Text('${item['firstName'][0].toUpperCase()} ${item['othernames'][0].toUpperCase()}',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),),
                              radius: 22,
                            ),
                            SizedBox(width: 10,),
                            Text('${item['firstName']} ${item['othernames']}',
                                // style: boldfont,
                                // style: TextStyle(fontSize: 13,fontFamily: GoogleFonts.poppins().fontFamily,fontWeight: FontWeight.bold)
                            ),
                          ],
                        ))
                      ]);
                    }).toList(),
                    // rows: [
                    //   DataRow(cells: [DataCell(Text('here is the name'))])
                    // ],
                  ),
                  Expanded(
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.white70),
                        headingRowHeight: 45,
                        dataRowMinHeight: 53,
                        dataRowMaxHeight: 53,
                        dividerThickness: 0.5,
                        border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                        columns: [
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
                        ],
                        rows: students.map((item){
                          return DataRow(cells: [
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
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Row(
                                  children: [
                                    (item['gender'] == "MALE" && item['gender'] != null) ? Icon(Icons.male,color: Colors.blue,) : Icon(Icons.female,color: Colors.pink,),
                                    SizedBox(width: 10,),
                                    Text('${item['gender']}',textAlign: TextAlign.start),
                                  ],
                                ),
                                Container(
                                  width: 50,
                                  // height: 68,
                                  child: PopupMenuButton(
                                    // offset: Offset(width * 0.3, appBarHeight),
                                    // color: darkmode ? Colors.black: Colors.grey[100],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade200
                                      ),
                                    ),
                                    icon: Icon(Icons.more_vert_rounded,color: Colors.blue,),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                            padding: EdgeInsets.all(0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width:100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: Colors.blue.withOpacity(0.5)
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      editDetails(item);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.edit,color: Colors.blue,),
                                                        SizedBox(width: 10,),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text('Edit'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Container(

                                                  width:100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: Colors.red.withOpacity(0.5)
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: (){

                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.delete,color: Colors.red,size: 14,),
                                                        SizedBox(width: 10,),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text('Delete'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ))
                ],
              ),
            ),
          ),


          // child: Container(
          //   child: HorizontalDataTable(
          //
          //     elevationColor: Colors.redAccent,
          //     isFixedHeader: true,
          //     itemCount: students.length,
          //     leftHandSideColumnWidth: 250,
          //     rowSeparatorWidget: const Divider(
          //       color: Colors.black38,
          //       height: 0.5,
          //       thickness: 0.5,
          //     ),
          //     headerWidgets: _headerwidgets(),
          //     rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
          //     leftSideItemBuilder: (BuildContext context, index){
          //       var clientdata = students[index];
          //       return Padding(
          //         padding: const EdgeInsets.only(top: 8.0,bottom: 8),
          //         child: Row(
          //           children: [
          //             CircleAvatar(
          //               radius: 17,
          //               backgroundColor: Colors.brown,
          //               child: Icon(Icons.computer,color: Colors.white,),
          //               // child: clients[index]['logo'] == null ? Text('-'): Image.network(auth.url+'/'+clients[index]['logo']),
          //             ),
          //             SizedBox(width: 20,),
          //             Text('${clientdata['firstName'].toUpperCase()} ${clientdata['othernames']}.',style: boldfont,),
          //             // SizedBox(height: 10,),
          //           ],
          //         ),
          //       );
          //     },
          //     rightSideItemBuilder: (BuildContext context, index){
          //       var clientdata = students[index];
          //       return Row(
          //         children: [
          //           Container(
          //               width: 200,
          //               // height: 68,
          //               child:  Padding(
          //                 padding: const EdgeInsets.only(top: 15.0,bottom: 15),
          //                 child: Text('${clientdata['admissionNo']}'),
          //               )
          //           ),
          //           Container(
          //             width: 200,
          //             // height: 68,
          //             child: Padding(
          //               padding: const EdgeInsets.only(top: 15,bottom: 15),
          //               child: Text('${clientdata['email']}',textAlign: TextAlign.start),
          //             ),
          //           ),
          //           Container(
          //             width: 200,
          //             // height: 68,
          //             child: Text('${clientdata['idNo']}',style: boldfont,textAlign: TextAlign.start,),
          //           ),
          //           Container(
          //             width: 200,
          //             // height: 68,
          //             child: Padding(
          //               padding: const EdgeInsets.only(left: 30,top: 15),
          //               child: Row(
          //                 children: [
          //                   (clientdata['gender'] == "MALE" && clientdata['gender'] != null) ? Icon(Icons.male,color: Colors.blue,) : Icon(Icons.female,color: Colors.pink,),
          //                   Text('${clientdata['gender']}',textAlign: TextAlign.start),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Container(
          //             width: 100,
          //             // height: 68,
          //             child: PopupMenuButton(
          //               // offset: Offset(width * 0.3, appBarHeight),
          //               // color: darkmode ? Colors.black: Colors.grey[100],
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10.0),
          //                 side: BorderSide(
          //                     width: 1,
          //                     color: Colors.grey.shade200
          //                 ),
          //               ),
          //               icon: Icon(Icons.more_vert_rounded,color: Colors.blue,),
          //               itemBuilder: (BuildContext context) {
          //                 return [
          //                   PopupMenuItem(
          //                     padding: EdgeInsets.all(0),
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           Container(
          //                             width:100,
          //                             decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(8),
          //                                 color: Colors.blue.withOpacity(0.5)
          //                             ),
          //                             child: GestureDetector(
          //                               onTap: (){
          //                                 editDetails(clientdata);
          //                               },
          //                               child: Row(
          //                                 children: [
          //                                   Icon(Icons.edit,color: Colors.blue,),
          //                                   SizedBox(width: 10,),
          //                                   Padding(
          //                                     padding: const EdgeInsets.all(8.0),
          //                                     child: Text('Edit'),
          //                                   )
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                           SizedBox(height: 10,),
          //                           Container(
          //
          //                             width:100,
          //                             decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(8),
          //                                 color: Colors.red.withOpacity(0.5)
          //                             ),
          //                             child: GestureDetector(
          //                               onTap: (){
          //
          //                               },
          //                               child: Row(
          //                                   children: [
          //                                     Icon(Icons.delete,color: Colors.red,size: 14,),
          //                                     SizedBox(width: 10,),
          //                                     Padding(
          //                                       padding: const EdgeInsets.all(8.0),
          //                                       child: Text('Delete'),
          //                                     )
          //                                   ],
          //                                 ),
          //                               ),
          //                           ),
          //                         ],
          //                       )
          //                   ),
          //                 ];
          //               },
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //
          //   ),
          // ),
        ),

      ],
    );
  }

  List<Widget> _headerwidgets() {
    return [
      Container(
          color: Theme.of(context).primaryColor,

          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 8,bottom: 8),
            child: Text('Name',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Reg No.',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Email',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 8,bottom: 8),
            child: Text('Phone',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,

          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Gender',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,

          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.more_horiz_outlined,color: Colors.white,),
          )
      ),
      // Text(''),
    ];
  }

}
