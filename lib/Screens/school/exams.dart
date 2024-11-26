import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web3/Screens/school/addExam.dart';
import '../../Constants/ImportUI.dart';
import '../../Constants/Reusableswidgets/btns.dart';
import '../../Constants/Reusableswidgets/textfield.dart';
import '../../Constants/Theme.dart';
import '../../all_homes.dart';

class Exams extends StatefulWidget {
  const Exams({super.key});

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {

  List students = [];

  var examName;

  getStudents()async{
    var resu = await auth.getvalues("school/exam/list?companyId=${companyIdInView}");
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
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(width: 0.5,color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  forms(
                      widthh: 250,
                      value: examName ?? '',
                      // initVal: name,
                      label: 'Exam Name',
                      hint: "Exam Name",
                      onChanged: (value){
                        setState(() {
                          examName = value;
                        });
                      }),
                  /*IconButton(onPressed: (){}, icon: Icon(Icons.search)),

                  IconButton(
                      onPressed: (){
                        getStudents();
                      }, icon: Icon(Icons.refresh,color: Colors.green,)
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,top: 16),
                    child: btns(
                      color: Colors.blueAccent,
                      icona: Icon(Icons.search),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,top: 16),
                    child: btns(
                      color: Colors.grey,
                      icona: Icon(Icons.lock_reset_outlined),
                    ),
                  )
                ],
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
                                      child: InkWell(
                                        onTap:((){
                                          editDetails(dat[ind]);
                                        }),
                                        child: Container(
                                          margin: EdgeInsets.all(2),
                                          width: (MediaQuery.of(context).size.width - 400) /4,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.library_books,size: 40,color: Colors.black,),
                                              SizedBox(width:10),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text('${dat[ind]['examName']}',style: boldfont,),
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width:100,
                                                            child: Text('Start Date:')
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text('${dat[ind]['startDate']}',style:boldfont),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width:100,
                                                            child: Text('End Date:')),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text('${dat[ind]['endDate']}',style:boldfont),
                                                        ),
                                                      ],
                                                    ),
                                                    Text('Duration:')
                                                  ],
                                                ),
                                              ),
                                              Icon(Icons.more_vert_rounded,color: Colors.black,)
                                            ],
                                          ),
                                        )),
                                      ),
                                    ))
                        ),
                      ),
                    ],
                  );
                });
          },),
        ),

      ],
    );
  }
}
