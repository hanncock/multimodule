import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';

class AddCompany extends StatefulWidget {
  final List? dets;
  const AddCompany({super.key, this.dets});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {

  late var id = widget.dets?[0]['id'];
  late var companyName = widget.dets?[0]['companyName'];
  late var regNo = widget.dets?[0]['regNo'];
  late var email = widget.dets?[0]['email'];
  late var phoneNo = widget.dets?[0]['phoneNo'].toString();
  late var KraPin = widget.dets?[0]['KraPin'].toString();
  late var NSSFNo = widget.dets?[0]['NSSFNo'];
  late var NhifNo = widget.dets?[0]['NhifNo'];
  late var country = widget.dets?[0]['country'];
  late var town = widget.dets?[0]['town'];
  late var postalAdd = widget.dets?[0]['postalAdd'];
  // late List modulesaccquired = widget.dets?[0]['modules'] ?? [];

  List modulesaccquired = [];
  List modsacq = [];
  getCompanyModules()async{
    var resu = await auth.getvalues('companymodule/list?companyId=${companyIdInView}');
    modsacq = resu;
    modulesaccquired.clear();
    for(int i=0; i<resu.length; i++){

      modulesaccquired.add(resu[i]['moduleId']);
    }
    setState(() {});
  }
  // late var maritalStatus = widget.dets?[0]['maritalStatus'];
  //
  var selectedVal;

  List modules = [];
  getModules()async{
    var resu = await auth.getvalues('module/list');
    setState(() {
      modules = resu;
    });
  }

  late Map data = {
    "id":id,
    "companyName":companyName,
    "regNo":regNo,
    "KraPin":KraPin,
    "NSSFNo":NSSFNo,
    "NhifNo":NhifNo,
    "postalAdd":postalAdd,
    "country":country,
    "town":town,
    "email":email,
    "phoneNo":phoneNo,
    "modules":jsonEncode(modulesaccquired),
  };





  saveCompanyModules(moddbId,modId)async{
    Map moddata = {
      "id":moddbId,
      "companyId":companyIdInView.toString(),
      "moduleId":modId.toString()
    };
    var resu = await auth.saveMany(moddata,'/api/companymodule/add');
    print(resu);
  }

  saveCompany()async{
    var resu = await auth.saveMany(data, "/api/company/add");
    print(resu);
  }

  @override
  void initState(){
    getModules();
    getCompanyModules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Company Profile',style: boldfont,),
                SizedBox(height: 20,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: Icon(Icons.person),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Click to upload',style: TextStyle(color: Colors.blue),),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text('General Company Information',style: boldfont,),
                SizedBox(height: 20,),
                Row(
                  children: [
                    forms(
                      label: "Company Name",
                      initVal: companyName,
                      onChanged: (value){
                        setState(() {
                          companyName = value;
                        });
                      },
                      value: companyName,
                    ),
                    forms(
                      label: "Registration No",
                      initVal: regNo,
                      onChanged: (value){
                        setState(() {
                          regNo = value;
                        });
                      },
                      value: regNo,
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text('Contact Information',style: boldfont,),
                SizedBox(height: 20,),
                Row(
                  children: [
                    forms(
                      label: "Email",
                      initVal: email,
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },
                      value: email,
                    ),
                    forms(
                      label: "Contact Info",
                      initVal: phoneNo,
                      onChanged: (value){
                        setState(() {
                          phoneNo = value;
                        });
                      },
                      value: phoneNo,
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text('Extra Details',style: boldfont,),
                SizedBox(height: 20,),
                Row(
                  children: [
                    forms(
                      label: "Country",
                      initVal: country,
                      onChanged: (value){
                        setState(() {
                          country = value;
                        });
                      },
                      value: country,
                    ),
                    forms(
                      label: "Town",
                      initVal: town,
                      onChanged: (value){
                        setState(() {
                          town = value;
                        });
                      },
                      value: town,
                    )
                  ],
                ),
                forms(
                  label: "Postal Address",
                  initVal: postalAdd,
                  onChanged: (value){
                    setState(() {
                      postalAdd = value;
                    });
                  },
                  value: postalAdd,
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    forms(
                      label: "Tax Pin",
                      initVal: KraPin,
                      onChanged: (value){
                        setState(() {
                          KraPin = value;
                        });
                      },
                      value: KraPin,
                    ),
                    forms(
                      label: "NSSF No",
                      initVal: NSSFNo,
                      onChanged: (value){
                        setState(() {
                          NSSFNo = value;
                        });
                      },
                      value: NSSFNo,
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text('Modules',style: boldfont,),
                SizedBox(height: 20,),
                modules.isEmpty?SizedBox():Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.grey[200]
                  ),
                  width: MediaQuery.of(context).size.width /4,
                  // height: 400,
                  child: ListView.builder(
                    itemCount: modules.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('${modules[index]['moduName']}',style: boldfont,),
                                  ),
                                  modulesaccquired.contains(modules[index]['id']) ? IconButton(
                                      onPressed: ()async{
                                        if(modulesaccquired.contains(modules[index]['id'])){
                                          var res =  modsacq.indexWhere((element) => element['moduleId'] == modules[index]['id']);
                                          var resu = await auth.delete(modsacq[res]['id'], "/companymodule/del");
                                          print(resu);
                                          modulesaccquired.remove(modules[index]['id'].toString());
                                        }
                                        setState(() {});
                                        getCompanyModules();

                                      },
                                      icon: Icon(Icons.toggle_on,size: 50,color: Colors.green,)) :
                                  IconButton(
                                      onPressed: (){

                                        if(!modulesaccquired.contains(modules[index]['id'])){
                                          modulesaccquired.add(modules[index]['id'].toString());
                                          saveCompanyModules(null,modules[index]['id'].toString());
                                        }
                                        setState(() {});
                                        print('${modulesaccquired}');
                                        // saveCompanyModules(null,modules[index]['id'].toString());
                                        getCompanyModules();

                                      },
                                      icon: Icon(Icons.toggle_off_outlined,color: Colors.red,size: 50,)
                                  )

                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
