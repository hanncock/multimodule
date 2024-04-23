import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/settings/addCompany.dart';

import '../../Constants/Reusableswidgets/btns.dart';
import '../crm/customers/importcustomers.dart';

class Companies extends StatefulWidget {
  const Companies({Key? key}) : super(key: key);

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {


  late List companies = [];
  var name;
  var selected;
  getcompanies()async{
    var resu = await auth.getcompany();
    if(resu.length == 0){
      print('empty');
    }else{
      companies = resu;
      setState(() {});
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
                    child: detail == null? Card(child: AddCompany()) : Card(child: AddCompany(dets: [detail],)),
                    // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                  ),
                );
              });
        });
  }


  upload(List? value,String todo){
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
                    child: ImportCust(
                      todo: todo,
                      title: 'Companies',
                      expectedVals: value,
                      endpoint: "/api/company/add",
                    ),
                    // child: detail == null? Card(child: AddCustomer()) : Card(child: AddCustomer(custDetails: [detail],)),
                    // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                  ),
                );
              });
        });
  }


  @override
  void initState(){
    super.initState();
    getcompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 400,
                    height:40,
                    child: TextField(
                      onChanged: (val){

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
                btns(label: '',icona: Icon(Icons.search),color: Colors.blueAccent,)
              ],
            ),
            Row(
              children: [
                btns(label: '',icona: Icon(Icons.refresh,color: Colors.green,),color:Colors.transparent,onclick: (){
                  getcompanies();
                },),
                SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: btns(
                    color: Colors.green,
                    label: 'Company',
                    icona: Icon(Icons.add),
                    onclick: (){
                      editDetails(null);
                    },),
                ),
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
                                  print('importing');
                                  // Uploader(todo: 'Import',value: ["companyName"],);
                                      upload(["companyName","regNo","KraPin","email","phoneNo"],"Import");
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
                                  upload(["companyName","regNo","KraPin","email","phoneNo"],'Download');
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
        Divider(color: Colors.black12,height: 0.5,),
        SizedBox(height: 10,),

        companies.isEmpty? Text('No Companies found'):Padding(
          padding: const EdgeInsets.all(8.0),
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
                      headingRowHeight: 45,
                      dataRowMinHeight: 53,
                      dataRowMaxHeight: 53,
                      dividerThickness: 0.5,
                      border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                      columns: [
                        DataColumn(label: Row(
                          children: [
                            Icon(Icons.person,color: Colors.black,),
                            Text('Company'),
                          ],
                        )),
                        DataColumn(label: Row(
                          children: [
                            Icon(Icons.phone,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Reg No'),
                          ],
                        )),
                        DataColumn(label: Row(
                          children: [
                            Icon(Icons.credit_card,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Kra Pin '),
                          ],
                        )),
                        DataColumn(label: Row(
                          children: [
                            Icon(Icons.mail,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Postal Code'),
                          ],
                        )),
                        DataColumn(label: Row(
                          children: [
                            Icon(Icons.location_on,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Email'),
                          ],
                        )),
                        DataColumn(label: Row(
                          children: [
                            Icon(Icons.generating_tokens,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Phone'),
                          ],
                        )),
                      ],
                      rows:companies.map((item){
                        return DataRow(
                          onSelectChanged: (selected){
                            editDetails(item);
                          },
                            cells: [
                          DataCell( InkWell(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.brown.withOpacity(0.2),
                                  child: Icon(Icons.computer,color: Colors.black12,),
                                  // child: clients[index]['logo'] == null ? Text('-'): Image.network(auth.url+'/'+clients[index]['logo']),
                                ),
                                SizedBox(width: 20,),
                                Text('${item['companyName'].toUpperCase()}.',style: boldfont,),
                                // SizedBox(height: 10,),
                              ],
                            ),
                          ),),
                          DataCell(Text('${item['regNo']}'),),
                          DataCell(Text('${item['kraPin']}'),),
                          DataCell(Text('${item['poastalAdd']}'),),
                          DataCell(Text('${item['email']}'),),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${item['phone']}'),
                              Container(
                                width: 50,
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
                                                    // editDetails(item);
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
                          ),),
                        ]);
                      }).toList()),
                ),
              ),
            ],
          ),
        ),
        // companies.isEmpty ?  Center(child: Text('We have no data')):Flexible(
        //   child: Container(
        //     child: HorizontalDataTable(
        //
        //       elevationColor: Colors.redAccent,
        //       isFixedHeader: true,
        //       itemCount: companies.length,
        //       leftHandSideColumnWidth: 250,
        //       rowSeparatorWidget: const Divider(
        //         color: Colors.black38,
        //         height: 0.5,
        //         thickness: 0.5,
        //       ),
        //       headerWidgets: _headerwidgets(),
        //       rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
        //       leftSideItemBuilder: (BuildContext context, index){
        //         var clientdata = companies[index];
        //         return Padding(
        //           padding: const EdgeInsets.only(top: 8.0,bottom: 8),
        //           child: Row(
        //             children: [
        //               CircleAvatar(
        //                 radius: 17,
        //                 backgroundColor: Colors.brown,
        //                 child: Icon(Icons.computer,color: Colors.white,),
        //                 // child: clients[index]['logo'] == null ? Text('-'): Image.network(auth.url+'/'+clients[index]['logo']),
        //               ),
        //               SizedBox(width: 20,),
        //               Text('${clientdata['companyName'].toUpperCase()}.',style: boldfont,),
        //               // SizedBox(height: 10,),
        //             ],
        //           ),
        //         );
        //       },
        //       rightSideItemBuilder: (BuildContext context, index){
        //         var clientdata = companies[index];
        //         return Row(
        //           children: [
        //             Container(
        //                 width: 200,
        //                 // height: 68,
        //                 child:  Padding(
        //                   padding: const EdgeInsets.only(top: 15.0,bottom: 15),
        //                   child: Text('${clientdata['regNo']}'),
        //                 )
        //             ),
        //             Container(
        //               width: 200,
        //               // height: 68,
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 15,bottom: 15),
        //                 child: Text('${clientdata['KraPin']}',textAlign: TextAlign.start),
        //               ),
        //             ),
        //             Container(
        //               width: 200,
        //               // height: 68,
        //               child: Text('${clientdata['postalAdd']}',style: boldfont,textAlign: TextAlign.start,),
        //             ),
        //             Container(
        //               width: 200,
        //               // height: 68,
        //               child: Padding(
        //                 padding: const EdgeInsets.only(left: 30,top: 15),
        //                 child: Text('${clientdata['email']}',textAlign: TextAlign.start),
        //               ),
        //             ),
        //             Container(
        //               width: 200,
        //               // height: 68,
        //               child: Padding(
        //                 padding: const EdgeInsets.only(left: 30,top: 15),
        //                 child: Text('${clientdata['phoneNo']}',textAlign: TextAlign.start),
        //               ),
        //             ),
        //             Container(
        //               width: 100,
        //               // height: 68,
        //               child: PopupMenuButton(
        //                 // offset: Offset(width * 0.3, appBarHeight),
        //                 // color: darkmode ? Colors.black: Colors.grey[100],
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10.0),
        //                   side: BorderSide(
        //                       width: 1,
        //                       color: Colors.grey.shade200
        //                   ),
        //                 ),
        //                 icon: Icon(Icons.more_vert_rounded,color: Colors.blue,),
        //                 itemBuilder: (BuildContext context) {
        //                   return [
        //                     PopupMenuItem(
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             GestureDetector(
        //                               onTap: (){
        //                                 // print('editing');
        //                                 // print(clientdata);
        //                                 editDetails(clientdata);
        //                               },
        //                               child: Row(
        //                                 children: [
        //                                   Icon(Icons.edit,color: Colors.blue,),
        //
        //                                   Padding(
        //                                     padding: const EdgeInsets.all(8.0),
        //                                     child: Text('Edit'),
        //                                   )
        //                                 ],
        //                               ),
        //                             ),
        //                             GestureDetector(
        //                               onTap: (){
        //
        //                               },
        //                               child: Row(
        //                                 children: [
        //                                   Icon(Icons.delete,color: Colors.red,),
        //                                   Padding(
        //                                     padding: const EdgeInsets.all(8.0),
        //                                     child: Text('Delete'),
        //                                   )
        //                                 ],
        //                               ),
        //                             )
        //                           ],
        //                         )
        //                     ),
        //                   ];
        //                 },
        //               ),
        //             ),
        //           ],
        //         );
        //       },
        //
        //     ),
        //   ),
        // ),
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
            child: Text('Company',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
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
            child: Text('Kra Pin',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 8,bottom: 8),
            child: Text('Postal Address',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
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
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Phone',style: TextStyle(color: Colors.white,letterSpacing: 1.0,),),
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
