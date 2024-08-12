import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/dropdown.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';

import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class ChargesSetup extends StatefulWidget {
  const ChargesSetup({super.key});

  @override
  State<ChargesSetup> createState() => _ChargesSetupState();
}

class _ChargesSetupState extends State<ChargesSetup> {

  var packageCode;
  var packageName;
  var chargeAmount;
  var postingAcc;
  var postingAccId;
  List postingAccs = [];
  var id;
  List packages = [];
  var debitAcc;
  var debitAccId;
  var creditAcc;
  var creditAccId;


  getPostingAccs()async{
    var resu = await auth.getvalues('accounting/accheader/list?companyId=${companyIdInView}&accType=Posting');
    setState(() {
      postingAccs = resu;
    });
  }

  getPackages()async{
    var resu = await auth.getvalues("accounting/chargepackage/list?companyId=${companyIdInView}");
    setState(() {
      packages = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getPostingAccs();
    getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              forms(
                initVal: packageCode ?? '',
                  label: 'Package Code',
                  value: packageCode,
                  widthh: 130,
                  hint: 'i.e 10001',
                  onChanged: (val){
                    setState(() {
                      packageCode = val;
                    });
                  }),
              forms(
                initVal: packageName,
                  label: 'Package Name',
                  value: packageName,
                  hint: 'i.e Fees/Transport/',
                  onChanged: (val){
                    setState(() {
                      packageName = val;
                    });
                  }),
              Container(
                width: 100,
                // child: TextFormField(
                //   initialValue: chargeAmount,
                //   style: TextStyle(color: Colors.blue),
                // ),
                child: Text('${chargeAmount}'),
              ),
              Row(
                children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Debit Acc',style: boldfont,),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5,color: Colors.black)
                      ),
                      width: 200,
                      height: 40,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            items: postingAccs.map((e) => DropdownMenuItem(
                                value: [e['headerName'], e['id']],
                                child: Text('${e['headerName']}'))).toList(),
                            hint: Text("${debitAcc?? ''}",style: boldfont,),
                            onChanged: (e){
                              var newvals = e as List;
                              debitAccId = newvals[1];
                              debitAcc = newvals[0];
                              setState(() {});
                            },
                          )
                      ),
                    ),
                  ],),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Credit Acc',style: boldfont,),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5,color: Colors.black)
                        ),
                        width: 200,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              items: postingAccs.map((e) => DropdownMenuItem(
                                  value: [e['headerName'], e['id']],
                                  child: Text('${e['headerName']}'))).toList(),
                              hint: Text("${creditAcc?? ''}",style: boldfont,),
                              onChanged: (e){
                                var newvals = e as List;
                                creditAccId = newvals[1];
                                creditAcc = newvals[0];
                                setState(() {});
                              },
                            )
                        ),
                      ),
                    ],
                  ),


                ],
              ),
              forms(
                initVal: chargeAmount,
                  label: 'Charge Amount',
                  value: chargeAmount,
                  hint: 'i.e 5,000',
                  onChanged: (val){
                    setState(() {
                      chargeAmount = val;
                    });
                  }),
              btns(label: 'Save',
                onclick: ()async{
                  Map moddata = {
                    "id":id,
                    "packageCode":packageCode,
                    "packageName":packageName,
                    // "postingAcc":postingAcc,
                    "chargeAmount":chargeAmount,
                    // "postingAccId":postingAccId,
                    "debitAccId":debitAccId,
                    "debitAcc":debitAcc,
                    "creditAcc":creditAcc,
                    "creditAccId":creditAccId,
                    "companyId":companyIdInView,
                  };
                  print(moddata);
                  var resu = await auth.saveMany(moddata,'/api/accounting/chargepackage/add');
                  print(resu);
                  getPackages();
                },
              )
            ],
          ),
          packages.isEmpty? SizedBox(): Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          showCheckboxColumn: false,
                          headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                          headingRowHeight: 45,
                          dataRowMinHeight: 53,
                          dataRowMaxHeight: 53,
                          dividerThickness: 0.5,
                          // border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                          columns: [
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.person,color: Colors.black,),
                                Text('code'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.app_registration,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Package Name'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.mail,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Debit Acc'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.mail,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Credit Acc'),
                              ],
                            )),
                            DataColumn(label: Row(
                              children: [
                                Icon(Icons.credit_card,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text('Charge Anount'),
                              ],
                            )),

                          ],
                          rows: packages.map((item){
                            return DataRow(
                                onSelectChanged: (selected){
                                  setState(() {
                                    packageCode = item['packageCode'];
                                    packageName = item['packageName'];
                                    id = item['id'];
                                    // postingAcc = item['postingAcc'];
                                    chargeAmount = item['chargeAmount'];
                                  });
                                  // print(item);
                                  print(chargeAmount);
                                  // if(packages.contains(item)){
                                  //   // selecteds.add(item);
                                  //   // editDetails(item);
                                  // }else{
                                  //   // selecteds.add(item);
                                  //
                                  // }
                                  setState(() {});

                                },
                                cells: [
                                  DataCell(Text('${item['packageCode']}')),
                                  DataCell(Text('${item['packageName']}',style: TextStyle(color: Colors.blue,),)),
                                  DataCell(Text('${item['debitAcc']}')),
                                  DataCell(Text('${item['creditAcc']}')),
                                  DataCell(Text('${item['chargeAmount']}',textAlign: TextAlign.start)),
                                ]);
                          }).toList(),
                        ),
                      )
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
