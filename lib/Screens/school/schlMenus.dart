import 'package:flutter/material.dart';
import 'package:web3/Constants/Theme.dart';

class SchlMenus{

  String title;
  Widget widget;
  final Icon icona;

  SchlMenus({
   required this.title,
   required this.widget,
   required this.icona
});

}


class SchlMenuList extends StatelessWidget {
  final SchlMenus schlMenus;
  const SchlMenuList({super.key,required this.schlMenus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          schlMenus.icona,
          SizedBox(width: 20,),
          // Flexible(child: Text(schlMenus.title.toUpperCase(),
          Flexible(child: Text(schlMenus.title,
            style: boldfont,
            softWrap: true,
          ))
        ],
      ),
    );
  }
}
