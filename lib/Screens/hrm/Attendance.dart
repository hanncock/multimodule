import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Theme.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  List attendances = [];
  List rowheaders = [
    'userId',
    'Name',
    'Time'
  ];

  getAttendances()async{
    var resu = await auth.getvalues("hrm/attendance/list");

    setState(() {
      attendances = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getAttendances();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children:List.generate(rowheaders.length, (index) => Container(
              width: MediaQuery.of(context).size.width / (rowheaders.length + 1),
              child: Text(''),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: Colors.black12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(rowheaders.length, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width/ (rowheaders.length + 1),
                        child: Text('${rowheaders[index]}')),
                  )),
                ),
              ),
            ),
          ),
          Expanded(child: attendances.isEmpty ? CircularProgressIndicator() :
              ListView(
                children: attendances.map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1,color: Colors.black12)
                      // border: Border(
                      //     bottom: BorderSide(
                      //         color: Colors.black12,
                      //         width: 1
                      //     )
                      // )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / (rowheaders.length + 1),
                            child: Text('${e['userId']}'),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / (rowheaders.length + 1),
                            child: Text('${e['employeeName'] ?? ''}'),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / (rowheaders.length + 1),
                            child: Text('${e['zkAttTimeTxt']}'),
                          )
                          // Text('$e'),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              )
          )
        ],
      ),
    );
  }
}
