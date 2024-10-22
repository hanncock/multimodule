import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Screens/crm/Projects/addproject.dart';
import '../../../Constants/Reusableswidgets/btns.dart';
import '../../../Constants/Theme.dart';
import '../customers/importcustomers.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  late List projects = [];

  project()async{
    var resu = await auth.getvalues("crm/project/list");
    setState(() {
      projects = resu;
    });
  }

  @override
  void initState(){
    project();
    // super.initState();
  }

  List excelVals = ["projectName","startDate","endDate","inchargeMail","inchargeContact","personInCharge","designation","projDescription","projectStatus"];


  editDetails(proj){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    // color: Colors.redAccent,
                    // child: Text('soke'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddProjects(Listproject:[proj]),
                      // child: Text('Editing'),
                      // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                    ),
                  ),
                );
              });
        });
  }


  upload(List? value,String todo){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: Text('Editing'),
                    child: ImportCust(
                      todo: todo,
                      title: 'Projects',
                      expectedVals: value,
                      endpoint: "/api/project/add",
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
            Row(
              children: [
                Container(
                    width: 400,
                    height:40,
                    child: TextField(
                      onChanged: (val){

                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          // labelText: widget.label,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.green
                            ),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10)

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5, color: Colors.black),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          // hintText: '${widget.hint}',
                          hintStyle: boldfont
                      ),
                    )
                ),
                SizedBox(width: 5,),
                btns(label: '',icona: Icon(Icons.search),color: Colors.blueAccent,)
              ],
            ),
            Row(
              children: [
                btns(label: '',icona: Icon(Icons.refresh,color: Colors.green,),color:Colors.transparent,onclick: (){
                  project();
                },),
                SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: btns(
                    color: Colors.green,
                    label: 'Project',
                    icona: Icon(Icons.add),
                    onclick: (){
                      // editDetails(null);
                    },),
                ),
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
                    child: Row(
                      children: [
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
                                      upload(excelVals,"Import");
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
                                    upload(excelVals,'Download');
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
        Divider(color: Colors.black12,height: 0.5,),
        SizedBox(height: 10,),

        projects.isEmpty ?  Center(child: Text('We have no data')):Flexible(
          child: Container(
            child: HorizontalDataTable(

              elevationColor: Colors.redAccent,
              isFixedHeader: true,
              itemCount: projects.length,
              leftHandSideColumnWidth: 250,
              rowSeparatorWidget: const Divider(
                color: Colors.black38,
                height: 0.5,
                thickness: 0.5,
              ),
              headerWidgets: _headerwidgets(),
              rightHandSideColumnWidth: MediaQuery.of(context).size.width -450,
              leftSideItemBuilder: (BuildContext context, index){
                var clientdata = projects[index];
                return Container(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0,bottom: 15,left: 10),
                    child: Text('${clientdata['projectName'].toUpperCase()}.',style: boldfont,textAlign: TextAlign.start),
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, index){
                var clientdata = projects[index];
                return Row(
                  children: [
                    Container(
                        width: 200,
                        // height: 68,
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 12.0,bottom: 15),
                          child: Text('${clientdata['startDate']}',textAlign: TextAlign.start),
                        )
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 12),
                        child: Text('${clientdata['endDate']}',textAlign: TextAlign.start),
                      ),
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Text('${clientdata['personInCharge']}',style: boldfont,textAlign: TextAlign.start,),
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,top: 15),
                        child: Text('${clientdata['designation']}',textAlign: TextAlign.start),
                      ),
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,top: 15),
                        child: Text('${clientdata['projectStatus']}',textAlign: TextAlign.start),
                      ),
                    ),
                    Container(
                      width: 100,
                      // height: 68,
                      child: PopupMenuButton(
                        // offset: Offset(width * 0.3, appBarHeight),
                        // color: darkmode ? Colors.black: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              width: 1,
                              color: Colors.grey.shade200
                          ),
                        ),
                        icon: Icon(Icons.more_vert_rounded,color: Colors.blue,),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        editDetails(clientdata);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit,color: Colors.blue,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Edit'),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap: ()async{
                                        print(clientdata['id']);
                                        var resu = await auth.delete(clientdata['id'],'/project/del');
                                        print(resu);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete,color: Colors.red,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Delete'),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ];
                        },
                      ),
                    ),
                  ],
                );
              },

            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _headerwidgets() {
    return [
      Container(
          color: Colors.grey[200],
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 8,bottom: 8),
            child: Text('Project'),
          )
      ),
      Container(
          color: Colors.grey[200],
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Start Date'),
          )
      ),
      Container(
          color: Colors.grey[200],
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 8,bottom: 8),
            child: Text('End Date'),
          )
      ),
      Container(
          color: Colors.grey[200],
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('In-Charge'),
          )
      ),
      Container(
          color: Colors.grey[200],
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Designation'),
          )
      ),
      Container(
          color: Colors.grey[200],
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 8,bottom: 8),
            child: Text('Status'),
          )
      ),
      Container(
          color: Colors.grey[200],
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.edit,color: Colors.deepOrange,),
          )
      ),
      // Text(''),
    ];
  }
}
