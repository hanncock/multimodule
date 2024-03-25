import 'package:flutter/material.dart';
import '../../Constants/Theme.dart';

class Crmenus{

  String title;
  Widget widget;
  final Icon icona;
  // final bool active;

  Crmenus({
    required this.title,
    required this.widget,
    required this.icona,
    // required this.active
});


}

class CrmMenuList extends StatelessWidget {
  final Crmenus crmenus;
  const CrmMenuList({Key? key, required this.crmenus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          crmenus.icona ,
          SizedBox(width: 20,),
          Flexible(child: Text(crmenus.title.toUpperCase(),style: menutitle,softWrap: true,))
        ],
      ),
    );
  }
}


