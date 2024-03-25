import 'package:flutter/material.dart';

import '../Theme.dart';

class forms extends StatefulWidget {
  final String? label;
  final String? initVal;
  final ValueChanged<String> onChanged;
  final value;
  double? widthh;
  String? hint;
  forms({
    Key? key,
    required this.value,
     this.label,
    this.widthh,
    this.hint,
    this.initVal,
    required this.onChanged,
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
            width: widget.widthh ?? 270 ,
            height: 43,//: widget.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: TextFormField(
              // controller: widget.value,
              initialValue: widget.initVal,
              textAlign: TextAlign.start,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  // labelText: widget.label,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Colors.green
                    ),

                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  hintText: '${widget.hint}',
                  hintStyle: boldfont
              ),
            ),
          ),

        ],
      ),
    );
  }
}