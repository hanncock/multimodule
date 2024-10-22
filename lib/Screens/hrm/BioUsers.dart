import 'package:flutter/material.dart';

import '../../Constants/Theme.dart';

class BioUsers extends StatefulWidget {
  const BioUsers({super.key});

  @override
  State<BioUsers> createState() => _BioUsersState();
}

class _BioUsersState extends State<BioUsers> {

  List users =[];
  List rowheders = [
    'User Id','Employee Name', 'Role','Password'
  ];
  getUsers()async{
    // var resu = await auth.getvalues('hrm/biousers/list?dvcSerialNo=3399170601165');
    var resu = await auth.getvalues('hrm/biousers/list');
    setState(() {
      users = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Device Name'),
              ),
              Text('${users[0]['dvcName'] ?? ''}')
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Device Serial'),
              ),
              Text('${users[0]['dvcSerialNo'] ?? ''}')
            ],
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
                  children: List.generate(rowheders.length, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width/ (rowheders.length + 1),
                        child: Text('${rowheders[index]}')),
                  )),
                ),
              ),
            ),
          ),
          Expanded(
            child: users.isEmpty? CircularProgressIndicator() :ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: users.map((e) => Padding(
                  padding: const EdgeInsets.all(5.0),
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
                              width: MediaQuery.of(context).size.width/ (rowheders.length + 1) ,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.black12,
                                          width: 1
                                      )
                                  )
                              ),
                              child: Text('${e['userId']}')),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.black45,
                                          width: 1
                                      )
                                  )
                              ),
                              width: MediaQuery.of(context).size.width/ (rowheders.length + 1) ,
                              child: Text('${e['employeeName'] ?? '-'}')),
                          Container(
                              width: MediaQuery.of(context).size.width/ (rowheders.length + 1) ,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.black12,
                                          width: 1
                                      )
                                  )
                              ),
                              child: Text('${e['role']}')),
                          Container(
                              width: MediaQuery.of(context).size.width/ (rowheders.length + 1) ,

                              child: Text('${e['password']}')),
                        ],
                      ),
                    ),
                  ),
                )
                  // Row(
                  // children: List.generate(e.length, (index) => Text('${e['userId']}'))
                  // )
                ).toList()
            ),
          ),
        ],

    );
  }
}
