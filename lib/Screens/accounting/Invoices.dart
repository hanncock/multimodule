import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:web3/Screens/Wrapper.dart';
import 'package:web3/Screens/accounting/newInvoice.dart';

import '../../Constants/Theme.dart';
import '../../all_homes.dart';
import 'getxcontroller.dart';

class Invoices extends StatefulWidget {
  const Invoices({super.key});

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  List invoices = [];


  getInvoices()async{
    var resu = await auth.getvalues('accounting/invoices/list?companyId=${companyIdInView}');
    // print('here is resu${resu}'r);
    setState(() {
      invoices = resu;
    });
  }






   late List<DatatableHeader> _headers;

  List<Map<String, dynamic>> _source = [
    {'name': 'soke', 'id': 1},
    {'name': 'soke', 'id': 2},
    {'name': 'soke', 'id': 3},
    {'name': 'soke', 'id': 4},
    {'name': 'soke', 'id': 5},
    {'name': 'soke', 'id': 6},
    {'name': 'soke', 'id': 7},
    {'name': 'soke', 'id': 8},
    {'name': 'soke', 'id': 9},
  ];


  @override
  void initState(){
    super.initState();
    _headers = [
      DatatableHeader(text: 'Name', value: 'name', show: true,
        sortable: true,),
      // DatatableHeader( show: true,
      //     sortable: true,text: 'Age', value: 'age'),
      DatatableHeader( show: true,
          sortable: true,text: 'Email', value: 'email'),
    ];
    getInvoices();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    TapController tapController = Get.put(TapController());

    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              if(tapController.openScreenstitlles.contains('New Invoice')){
                tapController.switchTo('New Invoice');
                DefaultTabController.of(context).animateTo(tapController.actvTab);
              }else{
                tapController.printList();
                tapController.addtoList('New Invoice',NewInvoice());
                tapController.switchTo('New Invoice');
                DefaultTabController.of(context).animateTo(tapController.actvTab);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.9),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1,color: Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                child: Text('New Invoice',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          // ResponsiveDatatable(
          //   headers: [
          //     DatatableHeader(text: 'Name', value: 'Name'),
          //     DatatableHeader(text: 'id', value: 'id'),
          //   ],
          //   source: [
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //     {'name':'soke','id':'id'},
          //   ],
          // )

          Container(
            width: MediaQuery.of(context).size.width,
            height: 700,
          child: Column(
            children: [
            //   ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: invoices.length,
            //     itemBuilder: (context,index){
            //       return Row(
            //         children: [
            //           Text('${invoices[index]['invNum']}'),
            //           Text('${invoices[index]['chargedAccount']}'),
            //           Text('${invoices[index]['total']}'),
            //           Text('${invoices[index]['invoiceDueDate']}'),
            //         ],
            //       );
            // }),
              invoices.isEmpty? SizedBox(): Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              showCheckboxColumn: false,
                              headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                              headingRowHeight: 45,
                              dataRowMinHeight: 53,
                              dataRowMaxHeight: 53,
                              dividerThickness: 0.5,
                              // border: const TableBorder(verticalInside: BorderSide(width: .05,)),
                              columns: [
                                DataColumn(label: Row(
                                  children: [
                                    Icon(Icons.person,color: Colors.black,),
                                    Text('Invoice Number'),
                                  ],
                                )),
                                // DataColumn(label: Row(
                                //   children: [
                                //     Icon(Icons.app_registration,color: Colors.black,),
                                //     SizedBox(width: 10,),
                                //     Text('Package Name'),
                                //   ],
                                // )),
                                DataColumn(label: Row(
                                  children: [
                                    Icon(Icons.mail,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text('Charged Account'),
                                  ],
                                )),
                                DataColumn(label: Row(
                                  children: [
                                    Icon(Icons.mail,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text('Total'),
                                  ],
                                )),
                                DataColumn(label: Row(
                                  children: [
                                    Icon(Icons.credit_card,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text('Due Date'),
                                  ],
                                )),
                                DataColumn(label: Text(""))

                              ],
                              rows: invoices.map((item){
                                return DataRow(
                                    onSelectChanged: (selected){

                                      print(selected);
                                      if(tapController.openScreenstitlles.contains('Invoice Details')){
                                        var containIndex = tapController.openScreenstitlles.indexOf("Invoice Details");
                                        print("here is the contained ${containIndex}");
                                        tapController.deleteTab(containIndex);
                                          print('switching');
                                          tapController.addtoList('Invoice Details',NewInvoice(invNum: item['invNum'],));
                                          tapController.switchTo('Invoice Details');
                                          DefaultTabController.of(context).animateTo(tapController.actvTab);

                                      }else{
                                        tapController.printList();
                                        tapController.addtoList('Invoice Details',NewInvoice(invNum: item['invNum'],));
                                        tapController.switchTo('Invoice Details');
                                        DefaultTabController.of(context).animateTo(tapController.actvTab);
                                      }
                                    },
                                    cells: [
                                      DataCell(Text('${item['invNum']}')),
                                      DataCell(Text('${item['chargedAccount']}',style: TextStyle(color: Colors.blue,),)),
                                      DataCell(Text('${item['total']}')),
                                      DataCell(Text('${item['invoiceDueDate'] ?? ''}')),
                                      DataCell(IconButton(
                                        onPressed: ()async{
                                          var resu = await auth.deleteInv(item['invNum'], "/accounting/invoices/del");
                                          print(resu);
                                          resu == 'success' ? getInvoices() : null;
                                        },
                                        icon:Icon(Icons.delete,color: Colors.redAccent,))),
                                      // DataCell(Text('${item['chargeAmount']}',textAlign: TextAlign.start)),
                                    ]);
                              }).toList(),
                            ),
                          )
                      ),
                    ],
                  )
                ],
              )
            ]
          ),
          /*  child: ResponsiveDatatable(
              headers: _headers,
              source: _source,

              // Optional parameters
              // canEdit: true,
              // canDelete: true,
              // canAdd: true,
              // sortAscending: true,
              // sortColumn: 'name',
              // onTabChange: (value) {},
              // onSort: (column, ascending) {},
              // onChanged: (value) {},
              // onRowSelect: (selected) {},
              // onRowDeSelect: (selected) {},
              // onAdd: (newData) {},
            ),*/
          ),

          // Column(
          //   children: [
          //     // Text('transactions'),
          //     // Text('${invoices}'),
          //     Container(
          //       // color: Colors.red,
          //       width: MediaQuery.of(context).size.width,
          //       height: MediaQuery.of(context).size.height * 0.7,
          //       child: ListView.builder(
          //         itemCount: invoices.length,
          //           shrinkWrap: true,
          //           itemBuilder: (context,index){
          //           return Text('${invoices[index]}');
          //       }),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

/*import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';


class DataPage extends StatefulWidget {
  DataPage({Key? key}) : super(key: key);
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late List<DatatableHeader> _headers;

  List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "id";

  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  String _selectableKey = "id";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;
  var random = new Random();

  List<Map<String, dynamic>> _generateData({int n = 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    print(i);
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "id": i,
        "sku": "$i\000$i",
        "name": "Product $i",
        "category": "Category-$i",
        "price": i * 10.00,
        "cost": "20.00",
        "margin": "${i}0.20",
        "in_stock": "${i}0",
        "alert": "5",
        "received": [i + 20, 150]
      });
      i++;
    }
    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      // _sourceOriginal.clear();
      // _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
      // _sourceFiltered = _sourceOriginal;
      // _total = _sourceFiltered.length;
      // _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
      _source = [{
        "id": "1",
        "sku": "2",
        "name": "Product ",
        "category": "Category-",
        "price":"4000",
        "cost": "20.00",
        "margin": "0.20",
        "in_stock": "0",
        "alert": "5",
        // "received": "150"
      }];
      setState(() => _isLoading = false);
    });
  }

  // _resetData({start = 0}) async {
  //   setState(() => _isLoading = true);
  //   var _expandedLen =
  //   _total - start < _currentPerPage! ? _total - start : _currentPerPage;
  //   Future.delayed(Duration(seconds: 0)).then((value) {
  //     _expanded = List.generate(_expandedLen as int, (index) => false);
  //     _source.clear();
  //     _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
  //     setState(() => _isLoading = false);
  //   });
  // }
  //
  // _filterData(value) {
  //   setState(() => _isLoading = true);
  //
  //   try {
  //     if (value == "" || value == null) {
  //       _sourceFiltered = _sourceOriginal;
  //     } else {
  //       _sourceFiltered = _sourceOriginal
  //           .where((data) => data[_searchKey!]
  //           .toString()
  //           .toLowerCase()
  //           .contains(value.toString().toLowerCase()))
  //           .toList();
  //     }
  //
  //     _total = _sourceFiltered.length;
  //     var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
  //     _expanded = List.generate(_rangeTop, (index) => false);
  //     _source = _sourceFiltered.getRange(0, _rangeTop).toList();
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() => _isLoading = false);
  // }

  @override
  void initState() {
    super.initState();

    /// set headers
    _headers = [
      DatatableHeader(
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "SKU",
          value: "sku",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Category",
          value: "category",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Price",
          value: "price",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Margin",
          value: "margin",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "In Stock",
          value: "in_stock",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Alert",
          value: "alert",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      // DatatableHeader(
      //     text: "Received",
      //     value: "received",
      //     show: true,
      //     sortable: false,
      //     sourceBuilder: (value, row) {
      //       List list = List.from(value);
      //       return Container(
      //         child: Column(
      //           children: [
      //             Container(
      //               width: 85,
      //               child: LinearProgressIndicator(
      //                 value: list.first / list.last,
      //               ),
      //             ),
      //             Text("${list.first} of ${list.last}")
      //           ],
      //         ),
      //       );
      //     },
      //     textAlign: TextAlign.center),
    ];

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(
                    maxHeight: 700,
                  ),
                  child: ResponsiveDatatable(
                    // title: TextButton.icon(
                    //   onPressed: () => {},
                    //   icon: Icon(Icons.add),
                    //   label: Text("new item"),
                    // ),
                    reponseScreenSizes: [ScreenSize.xs],
                    actions: [
                      // if (_isSearch)
                      //   Expanded(
                      //       child: TextField(
                      //         decoration: InputDecoration(
                      //             hintText: 'Enter search term based on ' +
                      //                 _searchKey!
                      //                     .replaceAll(new RegExp('[\\W_]+'), ' ')
                      //                     .toUpperCase(),
                      //             prefixIcon: IconButton(
                      //                 icon: Icon(Icons.cancel),
                      //                 onPressed: () {
                      //                   setState(() {
                      //                     _isSearch = false;
                      //                   });
                      //                   _initializeData();
                      //                 }),
                      //             suffixIcon: IconButton(
                      //                 icon: Icon(Icons.search), onPressed: () {})),
                      //         onSubmitted: (value) {
                      //           // _filterData(value);
                      //         },
                      //       )),
                      // if (!_isSearch)
                      //   IconButton(
                      //       icon: Icon(Icons.search),
                      //       onPressed: () {
                      //         setState(() {
                      //           _isSearch = true;
                      //         });
                      //       })
                    ],
                    headers: _headers,
                    source: _source,
                    selecteds: _selecteds,
                    showSelect: _showSelect,
                    autoHeight: false,
                    // dropContainer: (data) {
                    //   if (int.tryParse(data['id'].toString())!.isEven) {
                    //     return Text("is Even");
                    //   }
                    //   return _DropDownContainer(data: data);
                    // },
                    onChangedRow: (value, header) {
                      /// print(value);
                      /// print(header);
                    },
                    onSubmittedRow: (value, header) {
                      /// print(value);
                      /// print(header);
                    },
                    onTabRow: (data) {
                      print(data);
                    },
                    onSort: (value) {
                      setState(() => _isLoading = true);

                      setState(() {
                        _sortColumn = value;
                        _sortAscending = !_sortAscending;
                        if (_sortAscending) {
                          _sourceFiltered.sort((a, b) =>
                              b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                        } else {
                          _sourceFiltered.sort((a, b) =>
                              a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                        }
                        var _rangeTop = _currentPerPage! < _sourceFiltered.length
                            ? _currentPerPage!
                            : _sourceFiltered.length;
                        _source = _sourceFiltered.getRange(0, _rangeTop).toList();
                        _searchKey = value;

                        _isLoading = false;
                      });
                    },
                    expanded: _expanded,
                    sortAscending: _sortAscending,
                    sortColumn: _sortColumn,
                    isLoading: _isLoading,
                    onSelect: (value, item) {
                      print("$value  $item ");
                      if (value!) {
                        setState(() => _selecteds.add(item));
                      } else {
                        setState(
                                () => _selecteds.removeAt(_selecteds.indexOf(item)));
                      }
                    },
                    onSelectAll: (value) {
                      if (value!) {
                        setState(() => _selecteds =
                            _source.map((entry) => entry).toList().cast());
                      } else {
                        setState(() => _selecteds.clear());
                      }
                    },
                    footers: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Rows per page:"),
                      ),
                      if (_perPages.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton<int>(
                            value: _currentPerPage,
                            items: _perPages
                                .map((e) => DropdownMenuItem<int>(
                              child: Text("$e"),
                              value: e,
                            ))
                                .toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                _currentPerPage = value;
                                _currentPage = 1;
                                // _resetData();
                              });
                            },
                            isExpanded: false,
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child:
                        Text("$_currentPage - $_currentPerPage of $_total"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: _currentPage == 1
                            ? null
                            : () {
                          var _nextSet = _currentPage - _currentPerPage!;
                          setState(() {
                            _currentPage = _nextSet > 1 ? _nextSet : 1;
                            // _resetData(start: _currentPage - 1);
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 16),
                        onPressed: _currentPage + _currentPerPage! - 1 > _total
                            ? null
                            : () {
                          var _nextSet = _currentPage + _currentPerPage!;

                          setState(() {
                            _currentPage = _nextSet < _total
                                ? _nextSet
                                : _total - _currentPerPage!;
                            // _resetData(start: _nextSet - 1);
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      )
                    ],
                    headerDecoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border(
                            bottom: BorderSide(color: Colors.red, width: 1))),
                    selectedDecoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(color: Colors.green[300]!, width: 1)),
                      color: Colors.green,
                    ),
                    headerTextStyle: TextStyle(color: Colors.white),
                    rowTextStyle: TextStyle(color: Colors.green),
                    selectedTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ])),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Theme.dart';

class Invoices extends StatefulWidget {
  const Invoices({super.key});

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  late TabController controller2;

  List invoices = [];

  getInvoices()async{
    var resu = await auth.getvalues("accounting/transactionentry/list?type=INV&companyId=${companyIdInView}");
    setState(() {
      invoices = resu;
    });

    print(invoices);
  }

  @override
  void initState(){
    super.initState();
    getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [

      Container(
      child: Column(
      children: [
          GestureDetector(
          onTap: (){
    if(tapController.openScreenstitlles.contains('New Invoice')){
    tapController.switchTo('New Invoice');
    DefaultTabController.of(context).animateTo(tapController.actvTab);
    }else{
    tapController.printList();
    tapController.addtoList('New Invoice',NewInvoice());
    tapController.switchTo('New Invoice');
    DefaultTabController.of(context).animateTo(tapController.actvTab);
    }
    },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.9),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1,color: Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
          child: Text('New Invoice',style: TextStyle(color: Colors.white),),
        ),
      ),
    ))),

            Text('${invoices}')

          ],
        ),
      );
    }
  }*/

