import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class dropdwn extends StatelessWidget {

  final String label;
  final List<dynamic> values;
  final String? selectedval;
  double? widthh;
  final ValueChanged<String?> onChanged;
  dropdwn({
    Key? key,
    required this.label,
    required this.values,
    this.widthh,
    this.selectedval,
    required this.onChanged
  }) : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return DropdownButton<String>(
  //     value: selectedval,
  //     onChanged: onChanged,
  //     items: values.map((String option) {
  //       return DropdownMenuItem<String>(
  //         value: option,
  //         child: Text(option),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10,bottom: 10),
            child: Text('${label}',style: boldfont,),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            width: widthh ?? 300,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded:true,
                items: values.map((e) => DropdownMenuItem(
                    value: e.toString(),
                    // child: Text('${e}',style: boldfont,))),
                    child: Text('${e}',style: boldfont,))).toList(),
                value:selectedval,
                onChanged: onChanged

              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class dropdwn extends StatefulWidget {
//   final String label;
//   List values;
//   final String? selectedval;
//   double? widthh;
//   final ValueChanged<String> onChanged;
//   dropdwn({
//     Key? key,
//     required this.label,
//     required this.values,
//     this.widthh,
//     this.selectedval,
//   required this.onChanged
//   }) : super(key: key);
//
//   @override
//   State<dropdwn> createState() => _dropdwnState();
// }
//
// class _dropdwnState extends State<dropdwn> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left:10,bottom: 10),
//             child: Text('${widget.label}',style: boldfont,),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10)
//             ),
//             width: widget.widthh ?? 300,
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton2(
//                 isExpanded:true,
//                 items: widget.values.map((e) => DropdownMenuItem(
//                   value: e.toString(),
//                     // child: Text('${e}',style: boldfont,))),
//                     child: Text('${e}',style: boldfont,))).toList(),
//                 value: widget.selectedval,
//                 onChanged: (value) {
//                   setState(() {
//                     widget.selectedval == value;
//                   });
//                 },
//
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
