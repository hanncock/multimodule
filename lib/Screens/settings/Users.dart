import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/settings/adduser.dart';

import '../../Constants/Reusableswidgets/btns.dart';
import '../crm/customers/importcustomers.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {


  late List users = [];
  var name;
  var selected;

  getusers()async{
    var resu = await auth.getUsers();
    print(resu);
    if(resu.length == 0){
      print('empty');
    }else{
      users = resu;

      setState(() {});
    }
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
                      title: 'Users',
                      expectedVals: value,
                      endpoint: "/api/user/add",
                    ),
                  ),
                );
              });
        });
  }
  @override
  void initState(){
    super.initState();
    getusers();
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
                    child: detail == null? Card(child: AddUser()) : Card(child: AddUser(dets: [detail],)),
                    // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
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
                  getusers();
                },),
                SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: btns(
                    color: Colors.green,
                    label: 'Users',
                    icona: Icon(Icons.add),
                    onclick: (){
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
                                      upload(["firstName","otherNames","phone","idNo","gender","postalAdd","email"],"Import");
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
                                    upload(["firstName","otherNames","phone","idNo","gender","postalAdd","email"],'Download');
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

        users.isEmpty ?  Center(child: Text('We have no data')):Flexible(
          child: Padding(
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
                              Text('Name'),
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
                              Icon(Icons.credit_card,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('ID No'),
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
                              Icon(Icons.location_on,color: Colors.black,),
                              SizedBox(width: 10,),
                              Text('Postal Add'),
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
                        rows:users.map((item){
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
                                Text('${item['firstName'].toUpperCase()}.',style: boldfont,),
                                Text('${item['otherNames'].toUpperCase()}.',style: boldfont,),
                                // SizedBox(height: 10,),
                              ],
                            ),),
                            DataCell(Text('${item['phone']}'),),
                            DataCell(Text('${item['idNo']}'),),
                            DataCell(Text('${item['email']}'),),
                            DataCell(Text('${item['postalAdd']}'),),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item['gender']}'),
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
        ),
      ],
    );
  }
}
