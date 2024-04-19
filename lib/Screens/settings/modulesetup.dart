import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';

import '../../Constants/Theme.dart';

class ModuleSetup extends StatefulWidget {
  const ModuleSetup({super.key});

  @override
  State<ModuleSetup> createState() => _ModuleSetupState();
}

class _ModuleSetupState extends State<ModuleSetup> {

  var selected;
  var id;
  var moduleName;
  List modules = [];

  getModules()async{
    var resu = await auth.getvalues('module/list');
    setState(() {
      modules = resu;
    });
  }

  @override
  void initState(){
    getModules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              id == null ? SizedBox() :forms(value: moduleName,
                  label: '',
                  hint: '',
                  initVal: id,
                onChanged: (String value) {  },
              ),
              forms(value: moduleName,
                  label: 'Module Name',
                  hint: 'Module Name',
                  onChanged: (value){
                    setState(() {
                      moduleName = value;
                    });
                  }),
              Column(
                children: [
                  SizedBox(height: 38,),
                  btns(
                      label: 'Save Module',onclick: ()async{
                        Map data = {
                          "id":id,
                          "moduName":moduleName,
                        };
                        var resu = await auth.saveMany(data, "/api/module/add");
                        if(resu == 'success'){
                          setState(() {
                            moduleName == '';
                          });
                        }else{
                          print(resu);
                        }
                        print(resu);
                  }),
                ],
              )
            ],
          ),
          Divider(thickness: 0.5,),
          Flexible(child: ListView.builder(
              itemCount: modules.length,
              itemBuilder:(context, index){
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                          ),
                          child: InkWell(
                            onTap:(){
                              setState(() {
                                selected = modules[index];
                                id = modules[index]['id'];
                              });
                            },
                            child: Row(
                              children: [
                                modules[index] == selected ? Icon(Icons.check_box_outlined,color: Colors.blue,) :Icon(Icons.check_box_outline_blank,color: Colors.black,),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('${modules[index]['id']}',style: boldfont,),
                                      ),
                                      SizedBox(width: 30,),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('${modules[index]['moduName']}',style: boldfont,),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(Icons.edit,color: Colors.blue,),
                                Icon(Icons.delete,color: Colors.red,)
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                );
              } )
          )
        ],
      ),
    );
  }
}
