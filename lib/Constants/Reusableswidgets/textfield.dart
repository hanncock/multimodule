import 'package:flutter/material.dart';

import '../Theme.dart';

class forms extends StatefulWidget {

  final String? label;
  final String? initVal;
  final ValueChanged<String> onChanged;
  final Icon? icon;
  final value;
  double? widthh;
  double? heighht;
  String? hint;
  final int? linecnt;
  forms({
    Key? key,
    required this.value,
     this.label,
    this.widthh,
    this.hint,
    this.initVal,
    required this.onChanged,
    this.linecnt,
    this.icon
  }) : super(key: key);

  @override
  State<forms> createState() => _formsState();
}

class _formsState extends State<forms> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label == null? Text(''): Padding(
            padding: const EdgeInsets.only(left:10,bottom: 10),
            child: Text('${widget.label}',style: boldfont,),
          ),
          Container(
            width: widget.widthh ?? 300 ,
            height: (widget.linecnt == null ?42 : null),//: widget.width,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.black45),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(

                maxLines: widget.linecnt,
                initialValue: widget.initVal,
                // textAlign: TextAlign.justify,
                onChanged: widget.onChanged,
                style: TextStyle(fontSize: 14),


                // decoration: InputDecoration(
                //   labelText: "${widget.hint}",
                //   border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.redAccent),
                //     borderRadius: BorderRadius.circular(10.0),
                //   ),
                //   floatingLabelBehavior: FloatingLabelBehavior.always,
                //   floatingLabelStyle: TextStyle(fontFamily: "Muli"),
                // ),
                // style: boldfont,
                decoration: InputDecoration(
                  border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5,top: 2,bottom: 5),
                icon: widget.icon,

                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  floatingLabelStyle: TextStyle(fontFamily: "Muli"),
                //     fillColor: Colors.white,
                //     // floatingLabelBehavior: FloatingLabelBehavior.always,
                //     // labelText: widget.label,
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         // color: Colors.green
                //       ),
                //
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
                //         borderRadius: BorderRadius.circular(10)
                //
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(width: 0.5, color: Colors.black),
                //         borderRadius: BorderRadius.circular(10)
                //     ),
                    hintText: '${widget.hint}',
                    // hintStyle: boldfont
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}