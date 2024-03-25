import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/dropdown.dart';

import '../../../Constants/Theme.dart';

class Leads extends StatefulWidget {
  const Leads({super.key});

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {

  late List projects =[] ;
  var projoInView;
  var projoId;

  List  projoPrams = ["Potemtial","Reached Out","In Comm","Meeting Set","Presentation","Deal & Agreemnet","Deal Sent"];

  project()async{
    var resu = await auth.getProjects();
    setState(() {
      projects = resu;
    });
  }

  projectColumns()async{
    var resu = await auth.getProjects();
    setState(() {
      projects = resu;
    });
  }


  @override
  void initState(){
    project();
    // super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          projects.isEmpty ? Text('--') : Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select Project',style: boldfont),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: 300,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              isExpanded:true,
                              hint: Text('${projoInView ?? ''}',style: boldfont),
                              items: projects.map((e) => DropdownMenuItem(
                                  value:["${e['projectName']}","${e['projectId']}"],
                                  child: Text('${e['projectName']}',style: boldfont,))).toList(),
                              onChanged: (val){
                                setState(() {
                                  var vals = val as List;
                                  projoInView = vals[0].toString() ;
                                  projoId = vals[1] ;
                                });
                              }

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              projoInView == null ? Text('') :Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${projoInView ?? ''}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      color: Colors.orange
                    ),),
                ),
              ))
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  
                  children: List.generate(
                      growable: true,
                      projoPrams.length, (index) => Expanded(
                        child: Container(
                                            color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${projoPrams[index]}'),
                          ),
                        ),
                      )),
                  // children: [
                  //
                  // ],
                ),
              ),
              btns(label: 'Add')
            ],
          ),
        ],
      ),
    );
  }
}

