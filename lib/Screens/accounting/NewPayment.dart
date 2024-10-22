import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';

import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class NewPayment extends StatefulWidget {
  const NewPayment({super.key});

  @override
  State<NewPayment> createState() => _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment> {

  List invoices = [];
  List accountsToCharge = [];
  var selectedAccId;
  var selectedAcc ;
  var amntPaid;
  var referenceNum = "${(DateTime.now().year).toString()}${(DateTime.now().minute).toString()}${(DateTime.now().second).toString()}";
  var reftitile = 'Reference';
  var amount;
  var description;

  var payments = [];

  List paymentmethods = ["Cash","Cheque","BankTransfer","M-Pesa"];
  var paymentmethod ;




  getInvoices()async{
    invoices.clear();
    var resu = await auth.getvalues("accounting/transactionentry/list?chargedAccount=${selectedAcc}");
    setState(() {
      invoices = resu;
    });
  }

  getAccounts()async{
    var resu = await auth.getvalues('school/student/list?companyId=${companyIdInView}');
    setState(() {
      accountsToCharge = resu;
    });
  }


  @override
  void initState(){
    super.initState();
    getAccounts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Select Account/Customer'),
                      ),
                      Container(
                          width: 300,
                          height: 35,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
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
                                  getInvoices();
                                },
                                dropdownSearchData: DropdownSearchData(
                                  searchInnerWidgetHeight: 100,
                                  // searchController: textEditingController,
                                  searchInnerWidget: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        // controller: textEditingController,
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
                  SizedBox(height: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Date'),
                      Container(
                        width: 300,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1)
                        ),
                        child: Text("${DateTime.now()}"),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(width: 10,),

              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Payment Method'),
                      ),
                      Container(
                        width: 300,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            items: paymentmethods.map((e) => DropdownMenuItem(
                                value: e,
                                child: Text('$e'))).toList(),
                            hint: Text(paymentmethod ?? 'Select Payment Method'),
                            onChanged: (e){
                              setState(() {
                                paymentmethod = e;
                              });
                              print(paymentmethod);
                              switch(paymentmethod){
                                case "Cash":
                                  setState(() {
                                    reftitile = "Reference";
                                    paymentmethod = "CASH";
                                  });
                                  break;
                                case "Cheque":
                                  setState(() {
                                    reftitile = "Cheque";
                                    paymentmethod = "Cheque";
                                  });
                                  break;
                                case "M-Pesa":
                                  setState(() {
                                    reftitile = "Transaction";
                                    paymentmethod = "M-Pesa";
                                  });
                                  break;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${reftitile} Number'),
                      Container(
                        width: 300,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: referenceNum.toString(),
                            onChanged: (val){
                              setState(() {
                                referenceNum = val;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(width: 10,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  SizedBox(height: 30,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount'),
                      Container(
                        width: 300,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: amount,
                            onChanged: (val){
                              setState(() {
                                amount = val;
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Divider(),

          // Text('${invoices}'),
          invoices.isEmpty? SizedBox(): Column(
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
                          dataRowMinHeight: 40,
                          dataRowMaxHeight: 53,
                          dividerThickness: 0.5,
                          // border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                          columns: [
                            DataColumn(label: Text('Invoice Date')),
                            DataColumn(label: Text('Invoice Num')),
                            DataColumn(label: Text('Description')),
                            DataColumn(label: Text('Due Date')),
                            DataColumn(label: Text('Cost')),
                            DataColumn(label: Text('Amount Paid')),
                            DataColumn(label: Text('Balance')),

                          ],
                          rows: invoices.map((item){
                            return DataRow(
                                onSelectChanged: (selected){

                                },
                                cells: [
                                  DataCell(Text('${item['invoiceDate']}')),
                                  DataCell(Text('${item['invNum']}',style: TextStyle(color: Colors.blue,),)),
                                  DataCell(Text('${item['description'] ?? '-'}')),
                                  DataCell(Text('${item['invoiceDueDate'] ?? '-'}')),
                                  DataCell(Text('${item['cost']}',textAlign: TextAlign.start)),
                                  DataCell(Container(
                                    height:40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 1)
                                    ),
                                    width:200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        initialValue: item['credit'],
                                        decoration:InputDecoration(
                                          border: InputBorder.none,
                                        ),

                                        onChanged: (val){
                                          var amount = val;

                                          // var indfnd = fndResults.indexWhere((element) => element['subjectId'] == subjects[ind]['subjectId'] && element['studentId'] == item['id']);

                                          if(payments.indexWhere((element) => element['lineId'] == item['id']) == -1){

                                            print('does not contain');
                                            Map <String, dynamic> invline = {
                                              "transactionName": item['transactionName'],
                                              "invNum": item['invNum'],
                                              "transactionType": "PMT",
                                              "chargedAccount": item['chargedAccount'],
                                              "description": description,
                                              "cost": 0,
                                              // "quantity":quantity,
                                              "debit": 0,
                                              "debitAccId": item['debitAccId'],
                                              "debitAcc": item['debitAcc'],
                                              "credit": val,
                                              "creditAccId": item['creditId'],
                                              "creditAcc": item['creditAcc'],
                                              "companyId": companyIdInView,
                                              "paymentMethod": paymentmethod,
                                              "referenceNumber": referenceNum,
                                              "lineId": item['id']
                                            };
                                            payments.add(invline);


                                            // if(payments.contains(element))
                                          }else {
                                            print("contains");
                                            var fndInd = payments.indexWhere((element) => element['lineId'] == item['id']);
                                            print(fndInd);
                                            payments[fndInd]['credit'] = val;
                                          }
                                        },
                                      ),
                                    ),
                                  )),
                                  // DataCell(forms(
                                  //     label: 'Amount',
                                  //     value: amntPaid,
                                  //     onChanged: (val){
                                  //       setState(() {
                                  //         amntPaid = val;
                                  //       });
                                  //     })),
                                  // DataCell(Text('${item['cost']}',textAlign: TextAlign.start)),
                                  DataCell(Text('${ int.parse(item['cost']) - ((item['credit'] == null || item['credit'] == "" ) ? 0 : (int.parse(item['credit'])))}',textAlign: TextAlign.start)),
                                ]);
                          }).toList(),
                        ),
                      )
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: ()async{
              // print(payments);
              print(invoices);
              var resu = await auth.saveMany(payments, "/api/accounting/transactionentry/add");
              print(resu);
            },
            child: Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                child: Text('Save'),
              ),
            ),
          )
          /*DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                items: invoices.map((e) => DropdownMenuItem(
                  // value: [e['headerName'], e['id']],
                    value: [e],
                    child: Text('${e}',style: TextStyle(fontSize: 11),)
                )).toList(),
                  hint: Text("will update''}",style: boldfont,),
                  onChanged: (e){
                    // var stdntvals = e;
                    // selectedAcc = '${stdntvals[0]['admissionNo']}, ${stdntvals[0]['firstName']} ${stdntvals[0]['othernames']}';
                    // selectedAccId = stdntvals[0]['id'];
                    // setState(() {});
                    // debitAccId = newvals[1];
                    // debitAcc = newvals[0];
                    // setState(() {});
                  },
                  dropdownSearchData: DropdownSearchData(
                    searchInnerWidgetHeight: 100,
                    // searchController: textEditingController,
                    searchInnerWidget: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          // controller: textEditingController,
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
              )*/
        ],
      ),
    );
  }
}
