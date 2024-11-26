import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:web3/all_homes.dart';
import 'dart:html' as html;
import '../../Constants/Reusableswidgets/btns.dart';
import '../../Constants/Theme.dart';

import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PrintResults extends StatefulWidget {
  final String examCode;
  final String? classCode;
  final String? streamcode;
  final List subjects;
  final String examName;
  const PrintResults({super.key,
    required this.examCode,
    this.classCode,
    this.streamcode,
    required this.examName,
    required this.subjects,
  });

  @override
  State<PrintResults> createState() => _PrintResultsState();
}

class _PrintResultsState extends State<PrintResults> {

  List results =[];
  List subjectresults =[];


  getResults()async{
    var endpoint = "school/examresults/list?examId=${widget.examCode}" ;
    widget.streamcode == null ? endpoint = endpoint: endpoint = "$endpoint&stream=${widget.streamcode}";
    widget.classCode == null ? endpoint = endpoint: endpoint = "$endpoint&classeCode=${widget.classCode}";
    var resu = await auth.getvalues(endpoint);
    print(results);
    setState(() {
      results = resu;
    });
  }

  subjectResults()async{
    var endpoint = "school/examresult/list?examId=${widget.examCode}" ;
    widget.streamcode == null ? endpoint = endpoint: endpoint = "$endpoint&stream=${widget.streamcode}";
    widget.classCode == null ? endpoint = endpoint: endpoint = "$endpoint&classeCode=${widget.classCode}";
    var resu = await auth.getvalues(endpoint);
    print(results);
    setState(() {
      subjectresults = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getResults();
    subjectResults();
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        btns(
          onclick: (){
            _printScreenContent();
          },
          label: 'Print',
        ),
        Column(
          children: [
            Row(
              children: [
                DataTable(
                    columns: [
                      DataColumn(label: Text('#')),
                      DataColumn(label: Text('Student Name'))
                    ],
                    rows: results.map((e) => DataRow(cells:[
                      DataCell(Text(e['studentAdm'])),
                      DataCell(Text(e['studentName']))
                    ] )).toList()
                ),
                DataTable(columns: widget.subjects.map((e) =>DataColumn(label: Text('${e['subjectCode']}'))).toList(),
                    rows:results.map((e) => DataRow(
                        cells: List.generate(widget.subjects.length, (index) => DataCell(Text('${ subjectresults[subjectresults.indexWhere(
                                (element) => element['subjectId'] == widget.subjects[index]['subjectId'] && e['studentId'] == element['studentId'])]['results'] }')))
                    )).toList())
              ],
            ),

          ],
        ),
      ],
    );
  }

  _printScreenContent() async {
    final pdf = pw.Document();

    // Add the page with custom content matching your Flutter screen
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Column(
                  children:[
                    pw.Row(
                      children: [
                        /*pw.Container(
                          width: 100,
                          height: 100,
                          child: pw.Icon(Icons.compare as pw.IconData),),*/
                        pw.Text('$companyInView',style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          fontSize: 16
                        )),
                      ]
                  ),
                    pw.Text('${widget.examName}',style: pw.TextStyle(fontWeight: pw.FontWeight.bold,letterSpacing: 2)),
                    pw.Row(
                        children: [
                          pw.Text('Start Date: ____'),
                          pw.Text('End Date: ____'),
                          pw.Text('Examinees: ____'),
                          pw.Text('Students: ____'),
                        ]
                    ),
                  ]
                ),
                pw.SizedBox(height: 20),

                pw.Column(
                  children: [
                    pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: const <int, pw.TableColumnWidth>{
                          0: pw.IntrinsicColumnWidth(),
                          1: pw.FlexColumnWidth(),
                          2: pw.FixedColumnWidth(64),
                        },
                        children: [
                          pw.TableRow(
                              children: [
                                pw.Row(
                                  children:[
                                    pw.SizedBox(width:55,child:pw.Text('#')),
                                    pw.SizedBox(width:100,child:pw.Text('Student Name')),
                                  ]
                                ),
                                pw.Expanded(
                                    child: pw.Row(
                                        children: widget.subjects.map((e) => pw.SizedBox(
                                            width: 50,
                                            child:pw.Text('${e['subjectCode']}'))).toList()
                                    )
                                )
                              ]
                          )
                        ]
                    ),
                    pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: const <int, pw.TableColumnWidth>{
                          0: pw.IntrinsicColumnWidth(),
                          1: pw.FlexColumnWidth(),
                          2: pw.FixedColumnWidth(64),
                        },
                      // children:results.map((e) => pw.TableRow(children: [pw.Text('${e['studentName']}')])).toList()
                        children: results.map((e) => pw.TableRow(
                            children: [
                              pw.Row(
                                children:[
                                  pw.SizedBox(width:55,child:pw.Padding(
                                    padding: pw.EdgeInsets.only(left:5,),
                                    child:pw.Text('${e['studentAdm']}')
                                  )),
                                  pw.SizedBox(width:100,child:pw.Text('${e['studentName']}')),
                                ]
                              ),
                              pw.Expanded(
                                  child: pw.Row(
                                      children: widget.subjects.map((sbj)=>pw.SizedBox(width:50,child:pw.Text('${
                                          subjectresults[subjectresults.indexWhere(
                                                  (element) => element['subjectId'] == sbj['subjectId'] && e['studentId'] == element['studentId'])]['results']
                                      }'))).toList()

                                  )
                              )

                            ]
                        )).toList()
                      /*children:[
                        pw.TableRow(
                          children:[
                            pw.Column(
                              children:results.map((e) => pw.SizedBox(width: 100,child:pw.Text('${e['studentName']}'))).toList()
                            ),
                            pw.Expanded(
                              child: pw.Row(
                                  children: subjectresults.map((e) => pw.Text('${e['results']}')).toList()
                              )
                            )
                          ]
                        )
                        // results.map((e) => pw.TableRow(children: [pw.Text('${e['studentName']}')])).toList()
                      ]*/
                    )
                    // pw.DataTable()
                    /*pw.DataTable(
                        columns: [
                          pw.DataColumn(label: pw.Text('Student Name'))
                        ],
                        rows: results.map((e) => pw.DataRow(cells:[pw.DataCell(pw.Text(e['studentName']))] )).toList()
                    ),
                    pw.DataTable(
                        columns: widget.subjects.map((e) =>DataColumn(label: Text('${e['subjectCode']}'))).toList(),
                        rows:results.map((e) => DataRow(
                            cells: List.generate(widget.subjects.length, (index) => DataCell(Text('${ subjectresults[subjectresults.indexWhere(
                                    (element) => element['subjectId'] == widget.subjects[index]['subjectId'] && e['studentId'] == element['studentId'])]['results'] }')))
                        )).toList()
                    )*/
                  ],
                ),
              ]
          );
        },
      ),
    );

    // Open the print dialog
    Future.delayed(Duration(seconds: 2));
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) {
        // Return the PDF content directly without async
        return pdf.save();
      },
    );
  }
}
