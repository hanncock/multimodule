import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:web3/Screens/accounting/NewPayment.dart';
import 'package:web3/all_homes.dart';
import '../../Constants/Theme.dart';
import 'getxcontroller.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {

  List payments = [];

  getPayments()async{
    var resu = await auth.getvalues("accounting/payments/list?companyId=${companyIdInView}");
    setState(() {
      payments =resu;
    });
  }
  
  @override
  void initState(){
    super.initState();
    getPayments();
  }
  
  
  @override
  Widget build(BuildContext context) {
    TapController tapController = Get.put(TapController());


    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  if(tapController.openScreenstitlles.contains('New Payment')){
                    tapController.switchTo('New Payment');
                    DefaultTabController.of(context).animateTo(tapController.actvTab);
                  }else{
                    tapController.printList();
                    tapController.addtoList('New Payment',NewPayment());
                    tapController.switchTo('New Payment');
                    DefaultTabController.of(context).animateTo(tapController.actvTab);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1,color: Colors.transparent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                    child: Text('New Payment',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
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
                        DataColumn(label: Text('Reference Num')),
                        DataColumn(label: Text('Payment Method')),
                        DataColumn(label: Text('Charged Account')),
                        DataColumn(label: Text('Due Date')),
                        DataColumn(label: Text('Amount Paid')),
                        DataColumn(label: Text('Deposited to')),
                        DataColumn(label: Text('Received By')),
                        DataColumn(label: Text('Received On')),
                        // DataColumn(label: Text('Balance')),

                      ],
                      rows: payments.map((item){
                        return DataRow(
                            onSelectChanged: (selected){
                              setState(() {
                                // packageCode = item['packageCode'];
                                // packageName = item['packageName'];
                                // id = item['id'];
                                // postingAcc = item['postingAcc'];
                                // chargeAmount = item['chargeAmount'];
                              });
                            },
                            cells: [
                              DataCell(Text('${item['referenceNumber']}',style: TextStyle(color: Colors.blue,),)),
                              DataCell(Text('${item['invNum']}',style: TextStyle(color: Colors.blue,),)),
                              DataCell(Text('${item['chargedAccount'] ?? '-'}')),
                              DataCell(Text('${item['invoiceDate']}')),
                              DataCell(Text('${item['total'] ?? '-'}')),
                              DataCell(Text('${item['debitAcc'] ?? '-'}')),
                              DataCell(Text('${item['total'] ?? '-'}')),
                              DataCell(Text('${item['total'] ?? '-'}')),
                            ]);
                      }).toList(),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
