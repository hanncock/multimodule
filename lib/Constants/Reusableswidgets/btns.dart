import 'package:flutter/material.dart';

import '../Theme.dart';

class btns extends StatefulWidget {
  Icon? icona;
  // final Function? onclick
  void Function()? onclick;
  Color? color;

  final String? label;

  btns({
    Key? key,
    this.label,
    this.icona,
    this.onclick,
    this.color
  }) : super(key: key);

  @override
  State<btns> createState() => _btnsState();
}

class _btnsState extends State<btns> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onclick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(
            // color:  Theme.of(context).primaryColor,
            color: widget.color ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            widget.icona == null ? SizedBox() : widget.icona as Icon,
            widget.label == null ? SizedBox():Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Text('${widget.label}',style: menutitle,),
            ),
          ],
        ),
      ),
    );
  }
}
