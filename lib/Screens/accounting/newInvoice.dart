import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';

import '../../Constants/Theme.dart';
import '../../Constants/calender.dart';
import '../../all_homes.dart';

class NewInvoice extends StatefulWidget {
  const NewInvoice({super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {

  List accountsToCharge = [];
  var selectedAccId;
  final TextEditingController textEditingController = TextEditingController();
  var invoiceNum;
  var selectedAcc ;
  // TextEditingController quantity = TextEditingController();
  var invcedate = DateTime.now();
  var quantity;
  var invcduedate;
  List charges = [];
  var selectedCharge;
  var selectedChargeId;
  var description;
  // var cost;
  // TextEditingController cost = TextEditingController();
  var cost ;
  List newVals = [];
  var linetotal;


  List invceLines=[];


  getAccounts()async{
    var resu = await auth.getvalues('school/student/list?companyId=${companyIdInView}');
    setState(() {
      accountsToCharge = resu;
    });
  }

  getCharges()async{
    var resu = await auth.getvalues('accounting/chargepackage/list?companyId=${companyIdInView}');
    setState(() {
      charges = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getAccounts();
    getCharges();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
      child: Column(
        children: [
          Text('Invoice'),
          Container(
            decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      // mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Select Account',style: boldfont,),
                        ),
                        Container(
                            width: 300,
                            height: 35,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1,color: Colors.black)
                            ),
                            child: DropdownButtonHideUnderline(

                              child: DropdownButton2(

                                  isExpanded: true,
                                  items: accountsToCharge.map((e) => DropdownMenuItem(
                                    // value: [e['headerName'], e['id']],
                                      value: [e],
                                      child: Text('${e['admissionNo']}, ${e['firstName']},${e['othernames']}',style: TextStyle(fontSize: 11),)
                                  )).toList(),
                                  hint: Text("${selectedAcc?? ''}",style: boldfont,),
                                  onChanged: (e){
                                    var stdntvals = e;
                                    selectedAcc = '${stdntvals[0]['admissionNo']}, ${stdntvals[0]['firstName']} ${stdntvals[0]['othernames']}';
                                    selectedAccId = stdntvals[0]['id'];
                                    setState(() {});
                                    // debitAccId = newvals[1];
                                    // debitAcc = newvals[0];
                                    // setState(() {});
                                  },
                                  dropdownSearchData: DropdownSearchData(
                                    searchInnerWidgetHeight: 100,
                                    searchController: textEditingController,
                                    searchInnerWidget: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller: textEditingController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            hintText: 'Select Account...',
                                            hintStyle: const TextStyle(fontSize: 12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),)
                                    ),
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
                    forms(
                        label: 'Invoice Number',
                        value: invoiceNum,
                        onChanged: (val){
                          invoiceNum = val;
                        })
                  ],
                ),


                Column(
                  children: [
                    Calender(
                        initVal:frmtd.format(invcedate) ,//invcedate,
                        label: 'Invoice Date',
                        onChanged: (value){
                          setState((){
                            invcedate = value as DateTime;
                          });
                          // print('here is the value');
                          // print(value);
                        }
                    ),
                    SizedBox(height: 10,),
                    Calender(
                        initVal:invcduedate==null? invcduedate: frmtd.format(invcduedate),
                        label: 'Invoice Due Date',
                        onChanged: (value){
                          setState((){
                            invcduedate  = value as DateTime;
                          });
                          // print('here is the value');
                          // print(value);
                        }
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2,color: Colors.black),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.blue.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Charge Item',style: boldfont,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Description',style: boldfont),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Cost',style: boldfont),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Quatity',style: boldfont),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total Charge',style: boldfont),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(''),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3,bottom: 0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(width: 0.2,color: Colors.black)
                          ),
                          child:  Container(
                              width: 250,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: Colors.black12)
                              ),
                              child: DropdownButtonHideUnderline(

                                child: DropdownButton2(
                                    isExpanded: true,
                                    items: charges.map((e) => DropdownMenuItem(
                                        value: [e],
                                        child: Text('${e['packageName']}',style: TextStyle(fontSize: 11),)
                                    )).toList(),
                                    hint: Text("${selectedCharge ?? ''}",style: boldfont,),
                                    onChanged: (valu){
                                      var newvals = valu ;
                                      newVals = valu;

                                      selectedCharge = newvals[0]['packageName'];
                                      quantity = "1";
                                      cost = newvals[0]['chargeAmount']  ;
                                      linetotal = (int.parse(quantity) * int.parse(cost)).toString();
                                      setState(() {});
                                    },

                                    dropdownSearchData: DropdownSearchData(
                                        searchInnerWidgetHeight: 100,
                                        searchController: textEditingController,
                                        searchInnerWidget: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: TextFormField(
                                              controller: textEditingController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText: 'Select Charge...',
                                                hintStyle: const TextStyle(fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),)
                                        )
                                      // dropdownSearchData: DropdownSearchData(
                                      //   searchInnerWidget:
                                      //
                                      // ),
                                    )
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 300,
                          height:35,
                          child: TextFormField(
                            // initialValue:cost,
                            //   textDirection: TextDirection.ltr,
                            controller: TextEditingController(text: description),
                            onChanged: (newValue) {
                              setState(() {
                                description = newValue as TextEditingController;
                              });
                            },
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              // labelText: '${widget.label ?? ''}',
                              labelStyle: boldfont,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),

                        Container(
                          width: 300,
                          height:35,
                          child: TextFormField(
                            // initialValue:cost,
                            //   textDirection: TextDirection.ltr,
                            controller: TextEditingController(text: cost),
                            onChanged: (newValue) {

                              cost = (newValue as TextEditingController);
                              // cost = (newValue).toString();
                              // linetotal = (int.parse(quantity.toString()) * int.parse(cost.toString())).toString();
                              setState(() {});

                            },
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              // labelText: '${widget.label ?? ''}',
                              labelStyle: boldfont,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height:35,
                          child: TextFormField(
                            // initialValue:cost,
                            //   textDirection: TextDirection.ltr,
                            controller: TextEditingController(text: quantity),
                            onChanged: (newValue) {
                              quantity = (newValue as TextEditingController);
                              // quantity = (newValue as TextEditingController);
                              // quantity = newValue;
                              setState(() {});

                              linetotal = (int.parse(quantity.toString()) * int.parse(cost)).toString();
                              setState(() {});


                            },
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              // labelText: '${widget.label ?? ''}',
                              labelStyle: boldfont,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height:35,
                          child: TextFormField(
                            readOnly: true,
                            // initialValue:cost,
                            //   textDirection: TextDirection.ltr,
                            controller: TextEditingController(text: linetotal),
                            onChanged: (newValue) {
                              setState(() {
                                linetotal = newValue ;
                              });
                            },
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              // labelText: '${widget.label ?? ''}',
                              labelStyle: boldfont,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        btns(
                          label: 'Add Inv Line',
                          onclick: (){
                            textEditingController.clear();

                            Map <String,dynamic> invline = {
                              "transactionName":selectedCharge,
                              "invNum":invoiceNum,
                              "transactionType":"INV",
                              "chargedAccount":selectedAcc,
                              "description":description,
                              "cost":cost,
                              "quantity":quantity,
                              "debit":linetotal,
                              "debitAccId":newVals[0]['debitAccId'],
                              "debitAcc":newVals[0]['debitAcc'],
                              "credit":0,
                              "creditAccId":newVals[0]['creditId'],
                              "creditAcc":newVals[0]['creditAcc'],
                              "companyId":companyIdInView,
                              "invoiceDate":"$invcedate" ,
                              "invoiceDueDate":"$invcduedate",
                            };
                            invceLines.add(invline);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          invceLines.isEmpty?SizedBox():Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 400,minHeight: 400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.5),
                ),
                child: ListView.builder(
                    itemCount: invceLines.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: index.isEven ? Colors.grey[200] : Colors.transparent
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${index +1}.'),
                              ),
                              Container(
                                  width:300,
                                  child: Text('${invceLines[index]['transactionName']}')
                              ),
                              Container(
                                  width: 300,
                                  child: Text('${invceLines[index]['description']}')
                              ),
                              Container(
                                  width: 300,
                                  child: Text('${invceLines[index]['cost']}')
                              ),
                              Container(
                                  width: 300,
                                  child: Text('${invceLines[index]['quantity']}')
                              ),
                              Container(
                                  width: 300,
                                  child: Text('${invceLines[index]['debit']}')
                              ),
                              GestureDetector(
                                child: Icon(Icons.remove_circle_outline_rounded,color: Colors.red,),
                                onTap: (){
                                  invceLines.removeAt(index);
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btns(label: 'Save',
                    onclick: ()async{
                      var resu = await auth.saveMany(invceLines, '/api/accounting/transactionentry/add');
                      print(resu);
                      if(resu=='success'){
                        invceLines.clear();
                        setState(() {});
                      }
                    },
                  ),
                ],
              )
            ],
          ),


        ],
      ),
    );
  }
}
