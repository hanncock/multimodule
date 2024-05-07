// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:excel/excel.dart';
// import 'package:file_picker/file_picker.dart';
//
//
// class HomeSccreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Excel File'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             FilePickerResult? result = await FilePicker.platform.pickFiles(
//               type: FileType.custom,
//               allowedExtensions: ['xlsx'],
//             );
//
//             if (result != null) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ExcelDataScreen(
//                     excelData: result.files.first.bytes!.buffer.asUint8List(),
//                   ),
//                 ),
//               );
//             }
//           },
//           child: Text('Select Excel File'),
//         ),
//       ),
//     );
//   }
// }
//
// class ExcelDataScreen extends StatelessWidget {
//   final Uint8List excelData;
//
//   ExcelDataScreen({required this.excelData});
//
//   Future<List<List<dynamic>>> readExcelFile(Uint8List bytes) async {
//
//     try{
//     var excel = Excel.decodeBytes(bytes);
//
//     // Assuming there's only one sheet, you can change this if needed
//     var sheet = excel.tables.keys.first;
//     var table = excel.tables[sheet];
//
//     return table!.rows;
//   }catch (e) {
//       throw Exception('Error reading Excel file: $e');
//     }
//   }
//
//   // Error: Exception: Error reading Excel file: FormatException: Could not find End of Central Directory Record
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Excel Data'),
//       ),
//       body: FutureBuilder<List<List<dynamic>>>(
//         future: readExcelFile(excelData),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<List<dynamic>> data = snapshot.data!;
//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(data[index].join(', ')),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_excel/excel.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';

import '../../../Constants/Theme.dart';

class ImportCust extends StatefulWidget {
  final List? expectedVals;
  final String? title;
  final String todo;
  final String endpoint;
  const ImportCust({super.key,this.expectedVals, this.title, required this.todo,required this.endpoint});

  @override
  State<ImportCust> createState() => _ImportCustState();
}

class _ImportCustState extends State<ImportCust> {

  List headers = [];
  List _data = [];
  var filePath;
  String? fileName;
  bool hasheader = true;
  var extraVal;

  _pickFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    fileName = result.files.first.name;
    var excel =  Excel.decodeBytes(result.files.first.bytes!);

    var selectedExcel = excel;
    print(selectedExcel["Sheet1"].sheetName);
    Sheet sheet = selectedExcel["Sheet1"];
    var data = [];
      for (var row in excel.tables['Sheet1']!.rows) {
        setState(() {
          data.add(row);
        });
      }

      var values = [];
      for (int i = 0; i<data.length;){
        var rows = [];
        for(int j = 0; j<data[i].length; j++){

          if((data[i][j] == null) || (data[i][j].value == null) || (data[i][j].value == "")){
            rows.add('-');
          }else{
            rows.add(data[i][j].value);
          }
        }
        values.add(rows);
        i++;
      }
    if(hasheader){
      headers = values[0];
      values.removeAt(0);
      setState(() {});
      if(widget.expectedVals == null){
        setState(() {
          _data = values;
        });
      }else{
        List<String> missingValues3 = [];
        for(String value1 in headers!){
          if(!widget.expectedVals!.contains(value1)){
            missingValues3.add(value1);
          }
        }
        print(" missing or unknown values are :${missingValues3}");
        if(missingValues3.isEmpty){
          setState(() {
            extraVal = null;
            _data = values;
          });
        }else{
          setState(() {
            extraVal = missingValues3;
          });
        }
      }
    }

    /// Use FilePicker to pick files in Flutter Web

    // FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['xlsx'],
    //   allowMultiple: false,
    // );
    //
    // /// file might be picked
    //
    // if (pickedFile != null) {
    //   var bytes = pickedFile.files.single.bytes;
    //   var excel = Excel.decodeBytes(bytes!);
    //   for (var table in excel.tables.keys) {
    //     print(table); //sheet Name
    //     // print(excel.tables[table]!.maxColumns);
    //     print(excel.tables[table]!.maxRows);
    //     for (var row in excel.tables[table]!.rows) {
    //       print('$row');
    //     }
    //   }
    // }

  }


  convert(){

  }

  String csv = const ListToCsvConverter().convert(
    [
      ["Column1", "Column2"],
      ["Column1", "Column2"],
      ["Column1", "Column2"],
    ],
  );

  // Download and save CSV to your Device
  downloadCSV(String file) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    sheetObject.appendRow(widget.expectedVals!);
    var fileBytes = excel.save(fileName: '${widget.title ?? 'My file'}.xlsx');
    // List<CellValue> dataList = [TextCellValue('Google'), TextCellValue('loves'), TextCellValue('Flutter'), TextCellValue('and'), TextCellValue('Flutter'), TextCellValue('loves'), TextCellValue('Excel')];


    // Convert your CSV string to a Uint8List for downloading.
    // Uint8List bytes = Uint8List.fromList(utf8.encode(file));
    //
    // // This will download the file on the device.
    // await FileSaver.instance.saveFile(
    //   name: 'document_name', // you can give the CSV file name here.
    //   bytes: bytes,
    //   ext: 'xlsx',
    //   // mimeType: MimeType.csv,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('By default has headers'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('${fileName ?? ''}'),
                  SizedBox(width: 20,),
                  widget.todo == 'Download' ? Container(
                    child: Center(
                        child: btns(
                          color: Colors.cyan,
                          icona: Icon(Icons.download),
                          label: 'Download Excel',
                          onclick: ()async {
                            // String vals = ListToCsvConverter().convert(widget.expectedVals!.cast<List?>());
                            String vals = widget.expectedVals.toString();
                            // print(widget.expectedVals);
                            //When the download button is pressed, call `downloadCSV` function and pass the CSV string in it.
                            await downloadCSV(vals);
                          },)
                    ),
                  ):
                  Container(
                      width: 150,
                      child: Center(child: btns(
                        label: 'Pick file',
                        color: Colors.brown,
                        onclick: _pickFile,icona: Icon(Icons.bubble_chart_outlined),))),
                ],
              ),
            ),
            Divider(thickness: 0.5,),
            // _data.isEmpty?Text('no data') :Column(
            //   children: [
            //     Text("${headers}"),
            //
            //     Text("${_data}"),
            //   ],
            // ),
            extraVal==null ? Text(''):Text('Import Sheet Error in :${extraVal}'),
            _data.isEmpty ?  Text(''):Column(
              children: [
                Container(
                  // width: 600,
                  height: 620,
                  child: Center(
                    child: HorizontalDataTable(

                      elevationColor: Colors.redAccent,
                      isFixedHeader: true,
                      itemCount: _data.length,
                      leftHandSideColumnWidth: 180,
                      rowSeparatorWidget: const Divider(
                        color: Colors.black38,
                        height: 0.5,
                        thickness: 0.5,
                      ),
                      headerWidgets: _headerwidgets(),
                      rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
                      leftSideItemBuilder: (BuildContext context, index){
                        var tableData = _data[index];
                        return Container(
                            width: 180,
                            // height: 68,
                            child:  Padding(
                              padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                              child: Center(child: Text('${tableData[0].toString()}')),
                            )
                        );
                      },
                      rightSideItemBuilder: (BuildContext context, index){
                        var tableData = _data[index];
                        return Row(
                          children: List.generate(
                            tableData.length,
                                (val) =>  (val == 0) ? SizedBox() : Container(
                                width: 180,
                                // height: 68,
                                child:  Padding(
                                  padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                  child: Center(child: Text('${tableData[val].toString()}')),
                                )
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: btns(label: 'Save',color: Colors.green,icona: Icon(Icons.save),
                      onclick: (){
                        _saveData();
                      },
                      ),
                    ),
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  _saveData()async{

    List combined = [];
    for(int i=0; i<_data.length; i++){
       Map<String, dynamic> mapval = {};
      for(int j=0; j<headers.length; j++){
        mapval[headers[j]] = _data[i][j];
        // mapval.addAll({"${headers[j]}" : "${_data[i][j]}"});
      }
      combined.add(mapval);
    }
    // print(combined.runtimeType);
    var resu = await auth.saveMany(combined,widget.endpoint);
    // print(resu);
    if(resu == 'success'){
      Navigator.of(context).pop();
    }
    // print("here is ${resu}");

    // print(combined);
  }

  List<Widget> _headerwidgets() {
    return List.generate(
        headers.length, (index) => Container(
        color: Theme.of(context).primaryColor,
        width: 180,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,top: 8,bottom: 8),
          child: Text('${headers[index]}',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
        )
    ));
  }

}
