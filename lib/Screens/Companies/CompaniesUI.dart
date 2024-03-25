import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:web3/Constants/Theme.dart';

class Companies extends StatefulWidget {
  const Companies({Key? key}) : super(key: key);

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.all(defaultPadding),
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        // style: ,
                          // style: TextButton.styleFrom(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: defaultPadding * 1.5,
                          //         vertical: defaultPadding
                          //     )),
                          onPressed: (){
                            Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                          }, child: Text('Add')
                      ),
                      Container(
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                child: TextFormField(
                                  decoration: InputDecoration(

                                      hintText: 'test'
                                  ),

                                ),
                              ),
                              Text('Search'),
                            ],
                          )),
                    ],
                  ),
                ))
          ],
        ),
        SizedBox(height: defaultPadding,),

        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DataTable(
                  showCheckboxColumn: true,
                  checkboxHorizontalMargin: 5,
                  showBottomBorder: true,
                  // showCheckboxColumn: true,
                  dataRowMinHeight: 40,
                  // columnSpacing: ,
                  // headingRowColor: ,
                  columns: [
                    DataColumn(label: Text('Company')),
                    DataColumn(label: Text('Phone Num')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Address')),
                  ],
                  rows: List.generate(5, (index) => DataRow(cells: [
                    DataCell(
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              // radius:20,
                              child: Icon(Icons.computer),
                            ),
                            SizedBox(width: defaultPadding,),
                            Text('Company Name',style: TextStyle(fontWeight: FontWeight.bold),),

                          ],
                        )
                    ),
                    DataCell(Text('0712345678',style: TextStyle(fontWeight: FontWeight.w300),)),
                    DataCell(Text('mail@mail.com')),
                    DataCell(Text('soke')),
                  ])),

                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
