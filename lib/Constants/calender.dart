// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:vph_web_date_picker/vph_web_date_picker.dart';
// // //
// // // import 'Theme.dart';
// // //
// // // class Calender extends StatefulWidget {
// // //   final double? widthh;
// // //   final double? heighht;
// // //   final String? label;
// // //   final String? initialVal;
// // //   const Calender({super.key,this.initialVal,this.label,this.heighht, this.widthh});
// // //
// // //   @override
// // //   State<Calender> createState() => _CalenderState();
// // // }
// // //
// // // class _CalenderState extends State<Calender> {
// // //
// // //   late DateTime selectedDate = DateTime.now();
// // //   late TextEditingController _controller;
// // //   final textFieldKey = GlobalKey();
// // //
// // //   DateTime? _selectedDate;
// // //
// // //   void _handleDateChanged(DateTime date) {
// // //     setState(() {
// // //       _selectedDate = date;
// // //     });
// // //   }
// // //
// // //   @override
// // //   void initState(){
// // //     super.initState();
// // //     _controller =
// // //         TextEditingController(text: selectedDate.toString().split(' ')[0]);
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(8.0),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           widget.label == null? Text(''): Padding(
// // //             padding: const EdgeInsets.only(left:10,bottom: 10),
// // //             child: Text('${widget.label}',style: boldfont,),
// // //           ),
// // //           Container(
// // //             decoration: BoxDecoration(
// // //                 border: Border.all(width: 1,color: Colors.black45),
// // //                 borderRadius: BorderRadius.circular(6),
// // //                 color: Colors.white
// // //             ),
// // //             width: widget.widthh ?? 200 ,
// // //             // height: (widget.linecnt == null ?42 : null)
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //               children: [
// // //                 Expanded(
// // //                   child: TextFormField(
// // //                     // hint:,
// // //                     decoration: InputDecoration(
// // //                       border: InputBorder.none,
// // //                     ),
// // //                     key: textFieldKey,
// // //                     controller: _controller,
// // //                     readOnly: true,
// // //                     // initialValue: widget.initialVal,
// // //                     onTap: () async {
// // //                       final pickedDate = CalendarDatePicker(
// // //                         initialDate: DateTime.now(),
// // //                         firstDate: DateTime(2010),
// // //                         lastDate: DateTime(2100),
// // //                         onDateChanged: _handleDateChanged,
// // //                       );
// // //                       // final pickedDate = await showWebDatePicker(
// // //                       //
// // //                       //   context: textFieldKey.currentContext!,
// // //                       //   initialDate: selectedDate,
// // //                       //   firstDate: DateTime.now().subtract(const Duration(days: 7)),
// // //                       //   lastDate: DateTime.now().add(const Duration(days: 14000)),
// // //                       //   width: 300,
// // //                       //   //withoutActionButtons: true,
// // //                       //   weekendDaysColor: Colors.red,
// // //                       // );
// // //                       if (pickedDate != null) {
// // //                         print(pickedDate);
// // //                         // selectedDate = pickedDate;
// // //                         _controller =
// // //                             TextEditingController(text: pickedDate.toString().split(' ')[0]);
// // //                         setState(() {
// // //
// // //                         });
// // //                       }
// // //                     },
// // //                   ),
// // //                 ),
// // //                 InkWell(
// // //
// // //                     child: Icon(Icons.calendar_month,color: Colors.black,))
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// //
// // class Calender extends StatefulWidget {
// //   final ValueChanged onChanged;
// //   final select;
// //   const Calender({super.key, this.select,required this.onChanged,});
// //
// //   @override
// //   State<Calender> createState() => _CalenderState();
// // }
// //
// // class _CalenderState extends State<Calender> {
// //
// //   DateTime? _selectedDate;
// //
// //   void _handleDateChanged(DateTime date) {
// //     setState(() {
// //       _selectedDate = date;
// //       // _isDatePickerVisible = false; // Hide the date picker once the date is set
// //     });
// //     // print(_isDatePickerVisible);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Positioned(
// //       // top: 150, // Adjust the top position as needed
// //       // left: 0,
// //       // right: 0,
// //       child: Container(
// //         width: 200,
// //         height: 200,
// //         color: Colors.white,
// //         child: CalendarDatePicker(
// //           initialDate: _selectedDate ?? DateTime.now(),
// //           firstDate: DateTime(2010),
// //           lastDate: DateTime(2100),
// //           // onDateChanged: _handleDateChanged,
// //           onDateChanged: ((date){
// //             widget.onChanged;
// //           })//widget.onChanged,q
// //
// //
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// //
// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // class Calender extends StatefulWidget {
// // //   const Calender({super.key});
// // //
// // //   @override
// // //   State<Calender> createState() => _CalenderState();
// // // }
// // //
// // // class _CalenderState extends State<Calender> {
// // //
// // //   DateTime? _selectedDate;
// // //   bool _isDatePickerVisible = false;
// // //
// // //   void _toggleDatePickerVisibility() {
// // //     setState(() {
// // //       _isDatePickerVisible = !_isDatePickerVisible;
// // //     });
// // //   }
// // //
// // //   void _handleDateChanged(DateTime date) {
// // //     setState(() {
// // //       _selectedDate = date;
// // //       _isDatePickerVisible = false; // Hide the date picker once the date is set
// // //     });
// // //     print(_isDatePickerVisible);
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //         decoration: BoxDecoration(
// // //             color: Colors.white,
// // //             borderRadius: BorderRadius.circular(10),
// // //             border: Border.all(width: 1,color: Colors.black12)
// // //         ),
// // //         width: 250,
// // //         // height: 50,
// // //         child: Stack(children: [
// // //           TextFormField(
// // //             readOnly: true,
// // //             decoration: InputDecoration(
// // //               border: InputBorder.none,
// // //             ),
// // //             onTap: _toggleDatePickerVisibility,
// // //           ),
// // //           if (_isDatePickerVisible)
// // //             Positioned(
// // //               // top: 150, // Adjust the top position as needed
// // //               // left: 0,
// // //               // right: 0,
// // //               child: Container(
// // //                 width: 250,
// // //                 height: 200,
// // //                 color: Colors.white,
// // //                 child: CalendarDatePicker(
// // //                   initialDate: _selectedDate ?? DateTime.now(),
// // //                   firstDate: DateTime(2010),
// // //                   lastDate: DateTime(2100),
// // //                   onDateChanged: _handleDateChanged,
// // //                 ),
// // //               ),
// // //             ),
// // //
// // //         ],)
// // //     );
// // //   }
// // // }
// //
// //
// //
// //
// //
// //
// //
// // // if (_isDatePickerVisible)
// // // Positioned(
// // //   // top: 150, // Adjust the top position as needed
// // //   // left: 0,
// // //   // right: 0,
// // //   child: Container(
// // //     color: Colors.white,
// // //     child: CalendarDatePicker(
// // //       initialDate: _selectedDate ?? DateTime.now(),
// // //       firstDate: DateTime(2010),
// // //       lastDate: DateTime(2100),
// // //       onDateChanged: _handleDateChanged,
// // //     ),
// // //   ),
// // // ),
// //
// //
// //
// // // import 'package:flutter/material.dart';
// //
// // // class MyHomePage extends StatefulWidget {
// // //   @override
// // //   _MyHomePageState createState() => _MyHomePageState();
// // // }
// //
// // // class _MyHomePageState extends State<MyHomePage> {
// // //   DateTime? _selectedDate;
// // //   bool _isDatePickerVisible = false;
// // //
// // //   void _toggleDatePickerVisibility() {
// // //     setState(() {
// // //       _isDatePickerVisible = !_isDatePickerVisible;
// // //     });
// // //   }
// // //
// // //   void _handleDateChanged(DateTime date) {
// // //     setState(() {
// // //       _selectedDate = date;
// // //       _isDatePickerVisible = false; // Hide the date picker once the date is set
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Date Picker Example'),
// // //       ),
// // //       body: Center(
// // //         child: Stack(
// // //           children: <Widget>[
// // //             Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: <Widget>[
// // //                 Text(
// // //                   'Selected Date: ${_selectedDate?.toString() ?? "No date selected"}',
// // //                 ),
// // //                 SizedBox(height: 20),
// // //                 ElevatedButton(
// // //                   onPressed: _toggleDatePickerVisibility,
// // //                   child: Text('Select Date'),
// // //                 ),
// // //               ],
// // //             ),
// // //             if (_isDatePickerVisible)
// // //               Positioned(
// // //                 top: 150, // Adjust the top position as needed
// // //                 left: 0,
// // //                 right: 0,
// // //                 child: Container(
// // //                   color: Colors.white,
// // //                   child: CalendarDatePicker(
// // //                     initialDate: _selectedDate ?? DateTime.now(),
// // //                     firstDate: DateTime(2010),
// // //                     lastDate: DateTime(2100),
// // //                     onDateChanged: _handleDateChanged,
// // //                   ),
// // //                 ),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // // import 'package:flutter/material.dart';
// // // import 'package:vph_web_date_picker/vph_web_date_picker.dart';
// // //
// // // class MyHomePage extends StatefulWidget {
// // //   late final String? initialVal;
// // //   @override
// // //   _MyHomePageState createState() => _MyHomePageState();
// // // }
// //
// // // class _MyHomePageState extends State<MyHomePage> {
// // //
// // //
// // //   late DateTime selectedDate = DateTime.now();
// // //   late TextEditingController _controller;
// // //   final textFieldKey = GlobalKey();
// // //
// // //   bool showCal = false;
// // //
// // //   @override
// // //   void initState(){
// // //     super.initState();
// // //     _controller =
// // //         TextEditingController(text: selectedDate.toString().split(' ')[0]);
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //
// // //     return  Container(
// // //       decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(10),
// // //           border: Border.all(width: 1,color: Colors.black12)
// // //       ),
// // //       width: 150,
// // //       height: 43,
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //         children: [
// // //           Expanded(
// // //             child: TextFormField(
// // //               decoration: InputDecoration(
// // //                 border: InputBorder.none,
// // //               ),
// // //               key: textFieldKey,
// // //               controller: _controller,
// // //               readOnly: true,
// // //               initialValue: ,
// // //               // onTap: () async {
// // //               //   final pickedDate = await showWebDatePicker(
// // //               //
// // //               //     context: textFieldKey.currentContext!,
// // //               //     initialDate: selectedDate,
// // //               //     firstDate: DateTime.now().subtract(const Duration(days: 7)),
// // //               //     lastDate: DateTime.now().add(const Duration(days: 14000)),
// // //               //     width: 300,
// // //               //     //withoutActionButtons: true,
// // //               //     weekendDaysColor: Colors.red,
// // //               //   );
// // //               //   if (pickedDate != null) {
// // //               //     print(pickedDate);
// // //               //     // selectedDate = pickedDate;
// // //               //     _controller =
// // //               //         TextEditingController(text: pickedDate.toString().split(' ')[0]);
// // //               //     setState(() {
// // //               //
// // //               //     });
// // //               //   }
// // //               // },
// // //             ),
// // //           ),
// // //           InkWell(
// // //
// // //               child: Icon(Icons.calendar_month,color: Colors.black,))
// // //         ],
// // //       ),
// // //     );
// // //     // return Container(
// // //     //   width: 200,
// // //     //   height:200,
// // //     //   child: ElevatedButton(
// // //     //     onPressed: () async {
// // //     //       final picked = await showWebDatePicker(
// // //     //         // options:  DatePickerOptions(
// // //     //         //   dayTextStyle: TextStyle(
// // //     //         //     color: Colors.red, // Day text color
// // //     //         //   ),
// // //     //         //   monthTextStyle: TextStyle(
// // //     //         //     color: Colors.blue, // Month text color
// // //     //         //   ),
// // //     //         //   yearTextStyle: TextStyle(
// // //     //         //     color: Colors.green, // Year text color
// // //     //         //   ),
// // //     //         //   selectedDayBackgroundColor: Colors.yellow, // Selected day background color
// // //     //         // ),
// // //     //         context: context,
// // //     //         initialDate: _selectedDate ?? DateTime.now(),
// // //     //         firstDate: DateTime(2010),
// // //     //         lastDate: DateTime(2100),
// // //     //       );
// // //     //       if (picked != null) {
// // //     //         _handleDateSelect(picked);
// // //     //       }
// // //     //     },
// // //     //     child: Text('Change date'),
// // //     //   ),
// // //     // );
// // //   }
// // // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:vph_web_date_picker/vph_web_date_picker.dart';
// //
// // class Calender extends StatefulWidget {
// //   const Calender({super.key});
// //
// //   @override
// //   State<Calender> createState() => _CalenderState();
// // }
// //
// // class _CalenderState extends State<Calender> {
// //   TextEditingController _dateControler = TextEditingController();
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: 300,
// //       height: 300,
// //       child: TextField(
// //         controller: _dateControler,
// //         decoration: InputDecoration(
// //           labelText: 'DATE',
// //           filled: true,
// //         ),
// //         readOnly: true,
// //         onTap: () => showWebDatePicker(
// //             context: context,
// //             initialDate: DateTime.now(),
// //             firstDate: DateTime.now().subtract(const Duration(days: 7)),
// //             lastDate: DateTime.now().add(const Duration(days: 14000)),
// //             width: 300,
// //             withoutActionButtons: true,
// //             weekendDaysColor: Colors.red,
// //           )
// //           // _selectDates();
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
//
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

import 'Theme.dart';

class Calender extends StatefulWidget {
  final String? label;
  final String? initVal;
  final ValueChanged<String> onChanged;
  const Calender({super.key,required this.onChanged,this.label,this.initVal});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  TextEditingController _dateControler = TextEditingController();
  DateTime? selectedDate;

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
            width: 250,
            // height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black45),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white
            ),
            child: TextFormField(
              // controller: _dateControler,
              initialValue: widget.initVal,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5,top: 2,bottom: 5),
                labelText: widget.initVal ?? 'DATE',
                // filled: true,
              ),
              readOnly: true,
              onTap: (()async{
                // final DateTime? picked = await showWebDatePicker( // Use arrow function for cleaner syntax
                final DateTime? picked = await showWebDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  width: 250,
                  withoutActionButtons: false,
                  weekendDaysColor: Colors.red,

                  // onDateSelected: _handleDateSelection, // Handle date selection
                  // Handle date selection
                );
                if(picked != null){

                  // final f = new DateFormat('dd-MMM-yyyy | hh:mm a ');
                  // final ft = new DateFormat('yyyy-MM-dd');
                  // const dateFormat4 = 'yyyy-MM-dd';
                  // final frmtd = new DateFormat('d MMMM , y');
                  //
                  //
                  // DateTime date = DateTime.now();
                  //
                  // String formattedDate = DateFormat('MMMM d, y').format(date);
                    // // print(formattedDate); // Output: March 1, 2024
                  final ft = new DateFormat('yyyy-MM-dd');
                  var resu = ft.format(picked);
                  widget.onChanged(resu);
                }else{
                  // Navigator.of(context).pop();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}





