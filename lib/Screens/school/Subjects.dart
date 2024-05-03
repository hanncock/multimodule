import 'package:flutter/material.dart';
import 'package:web3/Screens/school/addSubject.dart';
import '../../Constants/ImportUI.dart';
import '../../Constants/Reusableswidgets/btns.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class Subjectc extends StatefulWidget {
  const Subjectc({super.key});

  @override
  State<Subjectc> createState() => _SubjectcState();
}

class _SubjectcState extends State<Subjectc> {

  List subjects = [];

  getSubjects()async{
    var resu = await auth.getvalues("school/subject/list?companyId=${companyIdInView}");
    setState(() {
      subjects = resu;
    });
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
                      child: detail == null? Card(child: AddSubject()) : Card(child: AddSubject(dets: [detail],)),
                      // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                    ),
                  ),
                );
              });
        });
  }

  @override
  void initState(){
    getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                        getSubjects();
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
                          child:btns(label:'Subject',
                            color: Colors.green,
                            icona: Icon(Icons.add,size: 14,),
                            onclick: (){
                              editDetails(null);
                              // upload(["clientName","clientEmail"],'Download');
                            },)),
                      // Container(
                      //   width: 120,
                      //   // height: 68,
                      //   decoration: BoxDecoration(
                      //       color: Theme.of(context).primaryColor,
                      //       borderRadius: BorderRadius.circular(10)
                      //   ),
                      //   child: PopupMenuButton(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       side: BorderSide(
                      //           width: 1,
                      //           color: Colors.grey.shade200
                      //       ),
                      //     ),
                      //     // child: Text('More'),
                      //     child: Row(
                      //       children: [
                      //         // btns(label: 'Print',icona: Icon(Icons.manage_search_sharp),),
                      //         btns(label: 'More',),
                      //         Icon(Icons.arrow_drop_down,)
                      //       ],
                      //     ),
                      //     itemBuilder: (BuildContext context) {
                      //       return [
                      //         PopupMenuItem(
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 btns(label:'Import',icona: Icon(Icons.import_export),color: Colors.brown,
                      //                     onclick:(){
                      //                       upload(["name","startDate","endDate","shrtfrm","companyId"],
                      //                           "Import",
                      //                           context,
                      //                           "Exam",
                      //                           "/exam/add"
                      //                       );
                      //                     }),
                      //                 SizedBox(height: 8),
                      //                 btns(label:'Export CSV',icona: Icon(Icons.comment_sharp),color: Colors.amber,onclick: (){
                      //                   // downloadCSV('test');
                      //                 },),
                      //                 SizedBox(height: 8),
                      //                 btns(label:'Export PDF',icona: Icon(Icons.picture_as_pdf_outlined),color: Colors.purple,),
                      //                 SizedBox(height: 8),
                      //                 btns(label:'Print',icona: Icon(Icons.print),),
                      //                 SizedBox(height: 8),
                      //                 btns(label:'Download Import Sheet',
                      //                   color: Colors.cyan,
                      //                   icona: Icon(Icons.download),
                      //                   onclick: (){
                      //
                      //                     upload(["name","startDate","endDate","shrtfrm","companyId"],
                      //                         'Download',
                      //                         context,
                      //                         "Exam",
                      //                         "/exam/add"
                      //                     );
                      //                   },)
                      //
                      //               ],
                      //             )
                      //         ),
                      //       ];
                      //     },
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
              Divider(height: 0.5,color: Colors.black12,),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: subjects.length,
                  itemBuilder: (context, index){
                return Card(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('${subjects[index]['subjectName']}',style: boldfont,),
                ));
              }),
            ]
        ),
      ),
    );
  }
}
