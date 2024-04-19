import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/crm/customers/importcustomers.dart';
import '../../../Constants/Reusableswidgets/btns.dart';
import 'addcustomer.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers>  with SingleTickerProviderStateMixin{


  late List clients = [];
  var name;

  client()async{
    var resu = await auth.getclients(null);
    if(resu.length == 0){
      print('empty');
    }else{
      clients = resu;

      setState(() {});
    }
  }

  @override
  void initState(){
    super.initState();
    client();
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
                    child: detail == null? Card(child: AddCustomer()) : Card(child: AddCustomer(custDetails: [detail],)),
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
                      title: 'ClientData',
                      expectedVals: value,
                      endpoint: "/api/client/add",
                    ),
                    // child: detail == null? Card(child: AddCustomer()) : Card(child: AddCustomer(custDetails: [detail],)),
                    // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
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
                    client();
                  },),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: btns(
                      color: Colors.green,
                      label: 'Customer',
                      icona: Icon(Icons.add),
                      onclick: (){
                        editDetails(null);
                        // var title = 'Add Customer';
                        // if(openScreenstitles.contains(title)){
                        //   print('${openScreenstitles},${openScreensWidgets}');
                        //   var activeIndex = openScreenstitles.indexOf(title);
                        //   print("contains ${activeIndex}");
                        //   DefaultTabController.of(context).animateTo(activeIndex);
                        // }else{
                        //   setState(() {
                        //     openScreenstitles.add(title);
                        //     openScreensWidgets.add(AddCustomer());
                        //     // activetab = index;
                        //   });
                        //   print('${openScreenstitles},${openScreensWidgets}');
                        //   var activeIndex = openScreenstitles.indexOf(title);
                        //   print("added ${activeIndex}");
                        //
                        //   controller2.animateTo(activeIndex);
                        //   setState(() {});
                        // }
                        // editDetails(null);
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
                                    upload(["clientName","clientEmail"],"Import");}),
                                  SizedBox(height: 8),
                                  btns(label:'Export CSV',icona: Icon(Icons.comment_sharp),color: Colors.amber,onclick: (){
                                    downloadCSV('test');
                                  },),
                                  SizedBox(height: 8),
                                  btns(label:'Export PDF',icona: Icon(Icons.picture_as_pdf_outlined),color: Colors.purple,),
                                  SizedBox(height: 8),
                                  btns(label:'Print',icona: Icon(Icons.print),),
                                  SizedBox(height: 8),
                                  btns(label:'Download Import Sheet',
                                    color: Colors.cyan,
                                    icona: Icon(Icons.download),
                                    onclick: (){upload(["clientName","clientEmail"],'Download');},)

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

          clients.isEmpty ?  Center(child: Text('We have no data')):Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: .5,color: Colors.black12)
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.white70),
                        headingRowHeight: 45,
                        dataRowMinHeight: 55,
                        dataRowMaxHeight: 55,
                        dividerThickness: 0.5,
                        columns: [
                          DataColumn(label: Row(
                            children: [
                              Icon(Icons.person,color: Colors.black,),
                              Text('Name'),
                            ],
                          ) ),
                          DataColumn(label: Row(
                            children: [
                              Icon(Icons.person,color: Colors.black,),
                              Text('Products'),
                            ],
                          ) ),

                          DataColumn(label: Row(
                            children: [
                              Icon(Icons.mail,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('Email'),
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
                              Icon(Icons.man,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('Conatact Person'),
                            ],
                          )),
                          DataColumn(label: Row(
                            children: [
                              Icon(Icons.location_on,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('Address'),
                            ],
                          )),
                          DataColumn(label: Row(
                            children: [
                              Icon(Icons.local_movies_outlined,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('Industry'),
                            ],
                          )),
                          DataColumn(label: Row(
                            children: [
                              Icon(Icons.temple_hindu_sharp,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('Client Type'),
                            ],
                          )),

                        ],
                        rows: clients.map((item){
                          return DataRow(cells: [
                            DataCell(Row(
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.brown.withOpacity(0.2),
                                  child: Icon(Icons.computer,color: Colors.white,),
                                  // child: clients[index]['logo'] == null ? Text('-'): Image.network(auth.url+'/'+clients[index]['logo']),
                                ),
                                SizedBox(width: 20,),
                                Text('${item['clientName'].toUpperCase()}.'),
                                // SizedBox(height: 10,),
                              ],
                            ),),
                            DataCell(Text('products go here',textAlign: TextAlign.start)),
                            DataCell(Text('${item['clientEmail']}',textAlign: TextAlign.start)),
                            DataCell(Text('${item['clientPhone']}')),
                            DataCell(Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item['contPersonName']}',style: boldfont,textAlign: TextAlign.start,),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      color: item['contPersonPhone'] == ''? Colors.white :Colors.green.withOpacity(0.2)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text('${item['contPersonPhone'] ?? '---'}'),
                                    )),
                              ],
                            ),),
                            DataCell(Text('${item['postalAdd']}',)),
                            DataCell(Text('${item['industry']}',)),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text('${item['clientType']}',),
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
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    print('editing');
                                                    editDetails(item);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.edit,color: Colors.blue,),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text('Edit'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                GestureDetector(
                                                  onTap: ()async{
                                                    // print(clientdata['id']);
                                                    var resu = await auth.delete(item['id'],'/client/del');
                                                    print(resu);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.delete,color: Colors.red,),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text('Delete'),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                              ],
                            )),

                          //                     c
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }

  String csv = const ListToCsvConverter().convert(
    [
      ["Column1", "Column2"],
      ["Column1", "Column2"],
      ["Column1", "Column2"],
    ],
  );

  // Download and save CSV to your Device
  downloadCSV(String file) async {
    // Convert your CSV string to a Uint8List for downloading.
    Uint8List bytes = Uint8List.fromList(utf8.encode(file));

    // This will download the file on the device.
    await FileSaver.instance.saveFile(
      name: file, // you can give the CSV file name here.
      bytes: bytes,
      ext: 'csv',
      mimeType: MimeType.csv,
    );
  }
}

