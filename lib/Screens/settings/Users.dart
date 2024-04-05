import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Constants/Theme.dart';

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
          child: Container(
            child: HorizontalDataTable(

              elevationColor: Colors.redAccent,
              isFixedHeader: true,
              itemCount: users.length,
              leftHandSideColumnWidth: 250,
              rowSeparatorWidget: const Divider(
                color: Colors.black38,
                height: 0.5,
                thickness: 0.5,
              ),
              headerWidgets: _headerwidgets(),
              rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
              leftSideItemBuilder: (BuildContext context, index){
                var clientdata = users[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.brown,
                        child: Icon(Icons.person_2_rounded,color: Colors.white,),
                      ),
                      SizedBox(width: 20,),
                      Row(
                        children: [
                          Text('${clientdata['firstName'].toUpperCase()}.',style: boldfont,),
                          Text('${clientdata['otherNames'].toUpperCase()}.',style: boldfont,),
                        ],
                      ),
                      // SizedBox(height: 10,),
                    ],
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, index){
                var clientdata = users[index];
                return Row(
                  children: [
                    Container(
                        width: 200,
                        // height: 68,
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                          child: Text('${clientdata['phone']}'),
                        )
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: Text('${clientdata['idNo']}',textAlign: TextAlign.start),
                      ),
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Text('${clientdata['postalAdd']}',style: boldfont,textAlign: TextAlign.start,),
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,top: 15),
                        child: Text('${clientdata['gender']}',textAlign: TextAlign.start),
                      ),
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,top: 15),
                        child: Text('${clientdata['email']}',textAlign: TextAlign.start),
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
                                        // print('editing');
                                        // editDetails(clients[index]);
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
                                    GestureDetector(
                                      onTap: (){

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
                );
              },

            ),
          ),
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
            child: Text('Names',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('phone',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Id No.',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
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
            child: Text('gender',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('email',style: TextStyle(color: Colors.white,letterSpacing: 1.0,),),
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
