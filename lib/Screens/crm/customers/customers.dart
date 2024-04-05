import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/crm/customers/importcustomers.dart';
import '../../../Constants/Reusableswidgets/btns.dart';
import '../../../Constants/Reusableswidgets/dropdown.dart';
import '../../../Constants/Reusableswidgets/textfield.dart';
import '../screen display.dart';
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
    var resu = await auth.getclients();
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
                        var title = 'Add Customer';
                        if(openScreenstitles.contains(title)){
                          print('${openScreenstitles},${openScreensWidgets}');
                          var activeIndex = openScreenstitles.indexOf(title);
                          print("contains ${activeIndex}");
                          DefaultTabController.of(context).animateTo(activeIndex);
                        }else{
                          setState(() {
                            openScreenstitles.add(title);
                            openScreensWidgets.add(AddCustomer());
                            // activetab = index;
                          });
                          print('${openScreenstitles},${openScreensWidgets}');
                          var activeIndex = openScreenstitles.indexOf(title);
                          print("added ${activeIndex}");

                          controller2.animateTo(activeIndex);
                          setState(() {});
                        }
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
            child: Container(
              child: HorizontalDataTable(

                elevationColor: Colors.redAccent,
                isFixedHeader: true,
                itemCount: clients.length,
                leftHandSideColumnWidth: 250,
                rowSeparatorWidget: const Divider(
                  color: Colors.black38,
                  height: 0.5,
                  thickness: 0.5,
                ),
                headerWidgets: _headerwidgets(),
                rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
                leftSideItemBuilder: (BuildContext context, index){
                  var clientdata = clients[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.brown,
                          child: Icon(Icons.computer,color: Colors.white,),
                          // child: clients[index]['logo'] == null ? Text('-'): Image.network(auth.url+'/'+clients[index]['logo']),
                        ),
                        SizedBox(width: 20,),
                        Text('${clientdata['clientName'].toUpperCase()}.',style: boldfont,),
                        // SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
                rightSideItemBuilder: (BuildContext context, index){
                  var clientdata = clients[index];
                  return SingleChildScrollView(
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          // height: 68,
                          child:  Row(
                            children: [
                              Icon(Icons.phone,color: Colors.green,size: 14,),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                child: Text('${clientdata['clientPhone']}'),
                              ),
                            ],
                          )
                        ),
                        Container(
                          width: 200,
                          // height: 68,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: Text('${clientdata['clientEmail']}',textAlign: TextAlign.start),
                          ),
                        ),
                        Container(
                          width: 200,
                          // height: 68,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${clientdata['contPersonName']}',style: boldfont,textAlign: TextAlign.start,),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Icon(Icons.phone,color: Colors.green,size: 14,),
                                  SizedBox(width: 5,),
                                  Text('${clientdata['contPersonPhone']}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 200,
                          // height: 68,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30,top: 15),
                            child: Text('${clientdata['postalAdd']}',textAlign: TextAlign.start),
                          ),
                        ),
                        Container(
                          width: 200,
                          // height: 68,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30,top: 15),
                            child: Text('${clientdata['clientAddress']}',textAlign: TextAlign.start),
                          ),
                        ),
                        Container(
                          width: 200,
                          // height: 68,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: Text('${clientdata['clientType']}',textAlign: TextAlign.start),
                          ),
                        ),
                        Container(
                          width: 200,
                          // height: 68,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: Text('${clientdata['industry']}',textAlign: TextAlign.start),
                          ),
                        ),
                        Container(
                          width: 100,
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
                                            editDetails(clients[index]);
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
                                            var resu = await auth.delete(clientdata['id'],'/client/del');
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
                    ),
                  );
                },

              ),
            ),
          ),
        ],
      ),
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
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Phone',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
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
            child: Text('Contact Person',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,

          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Address',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Products Acquired',style: TextStyle(color: Colors.white,letterSpacing: 1.0,),),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Client Type',style: TextStyle(color: Colors.white,letterSpacing: 1.0,),),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Industry',style: TextStyle(color: Colors.white,letterSpacing: 1.0,),),
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

