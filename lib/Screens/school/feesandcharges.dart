import 'package:flutter/cupertino.dart';

import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class FessandCharges extends StatefulWidget {
  final String? title;
  const FessandCharges({super.key, this.title});

  @override
  State<FessandCharges> createState() => _FessandChargesState();
}

class _FessandChargesState extends State<FessandCharges> {

  List trans = [];

  getTransactions()async{
    var resu = await auth.getvalues('accounting/transactionentry/list?companyId=${companyIdInView}&transactionName=${widget.title}');
    print(resu);
    setState(() {
      trans = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getTransactions();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: trans.map((e) => TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1,)
            // color: Colors.grey,
          ),
          children:[
            Text('${e['invNum']}'),
            Text('${e['transactionName']}'),
            Text('${e['chargedAccount']}'),

          ]
        )).toList(),
      ),
      // child: ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: trans.length,
      //     itemBuilder: (context, index){
      //       return TableRow(children: [
      //
      //       ]);
      // })
    );
  }
}
