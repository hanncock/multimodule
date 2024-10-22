import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/Wrapper.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';

class AddUser extends StatefulWidget {
  final List? dets;
  const AddUser({super.key,this.dets});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  late var id = widget.dets?[0]['id'];
  late var firstName = widget.dets?[0]['firstName'];
  late var otherNames = widget.dets?[0]['otherNames'];
  late var email = widget.dets?[0]['email'];
  late var phoneNo = widget.dets?[0]['phone'].toString() ?? "0";
  late var idNo = widget.dets?[0]['idNo'].toString();
  late var gender = widget.dets?[0]['gender'];
  late var postalAdd = widget.dets?[0]['postalAdd'];
  late var companyId = widget.dets?[0]['companyId'];
  // late var town = widget.dets?[0]['town'];
  // late var postalAdd = widget.dets?[0]['postalAdd'];

  late Map data = {
    "id":id,
    "firstName":firstName,
    "otherNames":otherNames,
    "email":email,
    "phoneNo":phoneNo,
    "idNo":idNo,
    "gendr":gender,
    "postalAdd":postalAdd,
  };

  late List companies = [];
  late List allowed = [];
  // var name;
  // var selected;
  getcompanies()async{
    var resu = await auth.getvalues("settings/company/list");
    if(resu.length == 0){
      print('empty');
    }else{
      setState(() {
        companies = resu;
      });
    }
  }
  
  getAllowedCompanies()async{
    var resu = await auth.getvalues("settings/usercompany/list?userId=${id}");
    setState(() {
      allowed = resu;
    });
  }



  @override
  void initState(){
    super.initState();
    getAllowedCompanies();
    getcompanies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5,color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Basic Information',style: boldfont,),
                              ),
                              Divider(thickness: 1,),
                              Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 100,
                                      backgroundColor: Colors.grey.withOpacity(0.1),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      forms(
                                        label: 'First Name',
                                        initVal: firstName,
                                        value: firstName,
                                        onChanged: (val){
                                          setState(() {
                                            firstName = val;
                                          });
                                        },
                                      ),
                                      forms(
                                        label: 'Other Names',
                                        initVal: otherNames,
                                        value: otherNames,
                                        onChanged: (val){
                                          setState(() {
                                            otherNames = val;
                                          });
                                        },
                
                                      ),
                                      Row(
                                        children: [
                                          forms(
                                            widthh: 300,
                                            label: 'ID No',
                                            initVal: idNo,
                                            value: idNo,
                                            onChanged: (val){
                                              setState(() {
                                                idNo = val;
                                              });
                                            },
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              dropdwn(
                                                widthh: 200,
                                                label: 'Gender',
                                                values: ['MALE','FEMALE'],
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    gender = value;
                                                  });
                                                },
                                                selectedval: gender,)
                                            ],
                                          ),
                                        ],
                                      ),
                
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 0.5,color: Colors.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Contact Information',style: boldfont,),
                                    ),
                                    Divider(thickness: 1,),
                                    forms(
                                      label: 'Email Addrss',
                                      initVal: email,
                                      value: email,
                                      onChanged: (val){
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                    ),
                                    forms(
                                      label: 'Phone Number',
                                      initVal: phoneNo,
                                      value: phoneNo,
                                      onChanged: (val){
                                        setState(() {
                                          phoneNo = val;
                                        });
                                      },

                                    ),
                                    forms(
                                      label: 'Postal Addr',
                                      initVal: postalAdd,
                                      value: postalAdd,
                                      onChanged: (val){
                                        setState(() {
                                          postalAdd = val;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              id != null ? Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 0.5,color: Colors.grey)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text('Allowed Companies ',style: boldfont,),
                                              Text('${Userdata['allowedCompanies'].length}',style: TextStyle(color: Colors.blue),),
                                            ],
                                          ),
                                        ),
                                        Divider(thickness: 1,),
                                        Container(
                                          // width: 600,
                                          height: 200,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                              itemCount: companies.length,
                                              itemBuilder: (context, index){
                                            return Container(
                                              margin: EdgeInsets.all(1),
                                              decoration:BoxDecoration(
                                                color: Colors.grey.shade100
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text('${companies[index]['companyName']}',style: boldfont,),
                                                  ),

                                                      allowed.where((element)=> element['companyId'] == companies[index]['id']).isNotEmpty? IconButton(
                                                      onPressed: ()async{
                                                        var ind = allowed.indexWhere((element) => element['companyId'] == companies[index]['id']);
                                                        var todel = allowed[ind]['id'];
                                                        var resu = await auth.delete(todel, "/settings/usercompany/del");
                                                        // print('here is resu of del companu${resu}');
                                                        getAllowedCompanies();
                                                      },
                                                      icon: Icon(Icons.toggle_on,size: 30,color: Colors.green,)) :
                                                  IconButton(
                                                      onPressed: ()async{
                                                        Map data = {
                                                          "id":null,
                                                          "userId":id,
                                                          "companyId":companies[index]['id'],
                                                        };
                                                        var resu = await auth.saveMany(data, "/api/settings/usercompany/add");
                                                        print(resu);
                                                        getAllowedCompanies();
                                                        setState(() {});
                                                      },
                                                      icon: Icon(Icons.toggle_off_outlined,color: Colors.red,size: 30,)
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text('User Module Settings ',style: boldfont,),
                                            // Text('${Userdata['allowedCompanies'].length}',style: TextStyle(color: Colors.blue),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // width: 600,
                                        height: 400,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: companies.length,
                                            itemBuilder: (context, index){
                                              return Container(
                                                margin: EdgeInsets.all(1),
                                                decoration:BoxDecoration(
                                                    color: Colors.grey.shade100
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text('${companies[index]['companyName']}',style: boldfont,),
                                                    ),
                                                    Icon(Icons.check_box_outlined),
                                                  ],
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Container(
                          //   height: 100,
                          //   width: 500,
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: 5,
                          //       // itemCount: modules.length,
                          //       itemBuilder: (context,index){
                          //         return Text('here goes the module rights');
                          //       }),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ): Text('')
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btns(
                  onclick: ()async{
                    var resu = await auth.saveMany(data, "/api/settings/user/add");
                    print(resu);
                  },
                  label: 'Add User',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
