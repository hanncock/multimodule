import 'package:flutter/material.dart';

import '../../Constants/Theme.dart';

class CrmCards{
  String title;
  int numbers;
  String description;

  CrmCards({
    required this.title,
    required this.numbers,
    required this.description
});

}


late final mycards = [

  CrmCards(
      title: 'Total Customers',
      numbers: 3846,
      description: "up 20%"
  ),
  CrmCards(
      title: 'Total Members',
      numbers: 204,
      description: "up 20%"
  )
];

class CrmCardsUI extends StatelessWidget {
  final CrmCards crmcards;
  const CrmCardsUI({Key? key, required this.crmcards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(crmcards.title),
                SizedBox(width: 200,),
                Icon(Icons.more_vert_rounded,color: Colors.black,)
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${crmcards.numbers}',style: modname,),
                SizedBox(width: 200,),
                Text(crmcards.description)
              ],
            )
          ],
        ),
      ),
    );
  }
}
