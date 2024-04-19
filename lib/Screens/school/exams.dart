import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Screens/school/addExam.dart';
import '../../Constants/ImportUI.dart';
import '../../Constants/Reusableswidgets/btns.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class Exams extends StatefulWidget {
  const Exams({super.key});

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {

  List students = [];

  getStudents()async{
    var resu = await auth.getvalues("exam/list?companyId=${companyIdInView}");
    setState(() {
      students = resu;
    });
  }

  @override
  void initState(){
    getStudents();
    super.initState();
  }

  editDetails(var detail){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300,vertical: 200),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Text('Editing'),
                      child: detail == null? Card(child: AddExam()) : Card(child: AddExam(dets: [detail],)),
                      // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                    ),
                  ),
                );
              });
        });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                // height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1,color: Colors.black12)
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Input the values",
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),

            IconButton(
                onPressed: (){
                  getStudents();
                }, icon: Icon(Icons.refresh,color: Colors.green,)
            ),
            // Icon(Icons.refresh,color: Colors.green,),
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:btns(label:'Exam',
                      color: Colors.green,
                      icona: Icon(Icons.add,size: 14,),
                      onclick: (){
                        editDetails(null);
                        // upload(["clientName","clientEmail"],'Download');
                      },)),
                Container(
                  width: 120,
                  // height: 68,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          width: 1,
                          color: Colors.grey.shade200
                      ),
                    ),
                    // child: Text('More'),
                    child: Row(
                      children: [
                        // btns(label: 'Print',icona: Icon(Icons.manage_search_sharp),),
                        btns(label: 'More',),
                        Icon(Icons.arrow_drop_down,)
                      ],
                    ),
                    // child: Text(''),
                    // icon: Icon(Icons.open_with_rounded,color: Colors.blue,),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                btns(label:'Import',icona: Icon(Icons.import_export),color: Colors.brown,
                                    onclick:(){
                                      upload(["name","startDate","endDate","shrtfrm","companyId"],
                                          "Import",
                                          context,
                                          "Exam",
                                          "/exam/add"
                                      );
                                    }),
                                SizedBox(height: 8),
                                btns(label:'Export CSV',icona: Icon(Icons.comment_sharp),color: Colors.amber,onclick: (){
                                  // downloadCSV('test');
                                },),
                                SizedBox(height: 8),
                                btns(label:'Export PDF',icona: Icon(Icons.picture_as_pdf_outlined),color: Colors.purple,),
                                SizedBox(height: 8),
                                btns(label:'Print',icona: Icon(Icons.print),),
                                SizedBox(height: 8),
                                btns(label:'Download Import Sheet',
                                  color: Colors.cyan,
                                  icona: Icon(Icons.download),
                                  onclick: (){

                                    upload(["name","startDate","endDate","shrtfrm","companyId"],
                                        'Download',
                                        context,
                                        "Exam",
                                        "/exam/add"
                                    );
                                  },)

                              ],
                            )
                        ),
                      ];
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        Divider(height: 0.5,color: Colors.black12,),
        students.isEmpty ?  Center(child: Text('We have no data')):Flexible(

          child: Builder(builder: (BuildContext context) {
            List<List<T>> splitList<T>(List<T> list, int chunkSize) {
              List<List<T>> chunks = [];
              for (var i = 0; i < list.length; i += chunkSize) {
                chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
              }
              return chunks;
            }
            List grouped = splitList(students, 4);

            return ListView.builder(
                itemCount: grouped.length,
                itemBuilder: (context, index){
                  var num = grouped[index].length;
                  List dat = grouped[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(num,
                                    (ind) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        margin: EdgeInsets.all(2),
                                        width: (MediaQuery.of(context).size.width - 320) /4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.library_books,size: 40,color: Colors.black,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text('${dat[ind]['examName']}',style: boldfont,),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('${dat[ind]['startDate']}'),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('${dat[ind]['endDate']}'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.more_vert_rounded,color: Colors.black,)
                                          ],
                                        ),
                                      )),
                                    ))
                        ),
                      ),
                    ],
                  );
                });
          },),

          // child: ListView.builder(
          //     itemCount: students.length,
          //     itemBuilder: (context, index){
          //
          //       List<List<T>> splitList<T>(List<T> list, int chunkSize) {
          //         List<List<T>> chunks = [];
          //         for (var i = 0; i < list.length; i += chunkSize) {
          //           chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
          //         }
          //         return chunks;
          //       }
          //       List grouped = splitList(students, 3);
          //       return Container(child: Text('${grouped[index]}'),);
          // }),
          //


          // child: ListView.builder(
          //   itemCount: students.length, // Change this according to your list size
          //   itemBuilder: (BuildContext context, int index) {
          //     if (index < 4) {
          //       return Row(
          //         children: List.generate(4, (subIndex) {
          //           return Expanded(
          //             child: Card(
          //               child: ListTile(
          //                 title: Text('Item ${(index)}'),
          //               ),
          //             ),
          //           );
          //         }),
          //       );
          //     } else {
          //       // return GridView.builder(
          //       //   shrinkWrap: true,
          //       //   physics: NeverScrollableScrollPhysics(),
          //       //   itemCount: 6, // Change this according to your list size
          //       //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       //     crossAxisCount: 4,
          //       //     crossAxisSpacing: 4.0,
          //       //     mainAxisSpacing: 4.0,
          //       //   ),
          //       //   itemBuilder: (BuildContext context, int subIndex) {
          //       //     return Card(
          //       //       child: ListTile(
          //       //         title: Text('Item ${(index * 4) + subIndex}'),
          //       //       ),
          //       //     );
          //       //   },
          //       // );
          //     }
          //   },
          // ),




          // child: Container(
          //   child: HorizontalDataTable(
          //
          //     elevationColor: Colors.redAccent,
          //     isFixedHeader: true,
          //     itemCount: students.length,
          //     leftHandSideColumnWidth: 250,
          //     rowSeparatorWidget: const Divider(
          //       color: Colors.black38,
          //       height: 0.5,
          //       thickness: 0.5,
          //     ),
          //     headerWidgets: _headerwidgets(),
          //     rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
          //     leftSideItemBuilder: (BuildContext context, index){
          //       var clientdata = students[index];
          //       return Container(
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 15,bottom: 15),
          //
          //           child: Text('${clientdata['examName'].toUpperCase()}',style: boldfont,),
          //         ),
          //       );
          //     },
          //     rightSideItemBuilder: (BuildContext context, index){
          //       var clientdata = students[index];
          //       return Row(
          //         children: [
          //           Container(
          //               width: 200,
          //               // height: 68,
          //               child:  Text('${clientdata['shrtfrm']}')
          //           ),
          //           Container(
          //             width: 200,
          //             // height: 68,
          //             child: Padding(
          //               padding: const EdgeInsets.only(top: 15,bottom: 15),
          //               child: Text('${clientdata['startDate']}',textAlign: TextAlign.start),
          //             ),
          //           ),
          //           Container(
          //             width: 200,
          //             // height: 68,
          //             child: Text('${clientdata['endDate']}',style: boldfont,textAlign: TextAlign.start,),
          //           ),
          //           Container(
          //             width: 100,
          //             // height: 68,
          //             child: PopupMenuButton(
          //               // offset: Offset(width * 0.3, appBarHeight),
          //               // color: darkmode ? Colors.black: Colors.grey[100],
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10.0),
          //                 side: BorderSide(
          //                     width: 1,
          //                     color: Colors.grey.shade200
          //                 ),
          //               ),
          //               icon: Icon(Icons.more_vert_rounded,color: Colors.blue,),
          //               itemBuilder: (BuildContext context) {
          //                 return [
          //                   PopupMenuItem(
          //                       padding: EdgeInsets.all(0),
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           Container(
          //                             width:100,
          //                             decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(8),
          //                                 color: Colors.blue.withOpacity(0.5)
          //                             ),
          //                             child: GestureDetector(
          //                               onTap: (){
          //                                 editDetails(clientdata);
          //                               },
          //                               child: Row(
          //                                 children: [
          //                                   Icon(Icons.edit,color: Colors.blue,),
          //                                   SizedBox(width: 10,),
          //                                   Padding(
          //                                     padding: const EdgeInsets.all(8.0),
          //                                     child: Text('Edit'),
          //                                   )
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                           SizedBox(height: 10,),
          //                           Container(
          //
          //                             width:100,
          //                             decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(8),
          //                                 color: Colors.red.withOpacity(0.5)
          //                             ),
          //                             child: GestureDetector(
          //                               onTap: (){
          //
          //                               },
          //                               child: Row(
          //                                 children: [
          //                                   Icon(Icons.delete,color: Colors.red,size: 14,),
          //                                   SizedBox(width: 10,),
          //                                   Padding(
          //                                     padding: const EdgeInsets.all(8.0),
          //                                     child: Text('Delete'),
          //                                   )
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       )
          //                   ),
          //                 ];
          //               },
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //
          //   ),
          // ),
        ),

      ],
    );
  }

  List<Widget> _headerwidgets() {
    return [
      Container(
          color: Theme.of(context).primaryColor,

          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 8,bottom: 8),
            child: Text('Name',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 8,bottom: 8),
            child: Text('Acronym',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Start Date.',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('End Date',style: TextStyle(color: Colors.white,letterSpacing: 1.0,)),
          )
      ),
      Container(
          color: Theme.of(context).primaryColor,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.more_horiz_outlined,color: Colors.white,),
          )
      ),
      // Text(''),
    ];
  }

}
