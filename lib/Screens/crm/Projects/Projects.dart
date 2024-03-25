import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web3/Screens/crm/Projects/addproject.dart';

import '../../../Constants/Reusableswidgets/btns.dart';
import '../../../Constants/Theme.dart';
import '../screen display.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  late List projects = [];

  project()async{
    var resu = await auth.getProjects();
    setState(() {
      projects = resu;
    });
  }

  @override
  void initState(){
    project();
    // super.initState();
  }


  editDetails(){
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
                      child: Text('Editing'),
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: btns(
                label: 'Add Project',
                icona: Icon(Icons.add),
                onclick: (){
                  var title = 'Add Project';
                  if(openScreenstitles.contains(title)){
                    print('${openScreenstitles},${openScreensWidgets}');
                    var activeIndex = openScreenstitles.indexOf(title);
                    print("contains ${activeIndex}");
                    // DefaultTabController.of(context).animateTo(activeIndex);
                  }else{
                    setState(() {
                      openScreenstitles.add(title);
                      openScreensWidgets.add(AddProjects());
                      // activetab = index;
                    });
                    print('${openScreenstitles},${openScreensWidgets}');
                    var activeIndex = openScreenstitles.indexOf(title);
                    print("added ${activeIndex}");

                    // DefaultTabController.of(context).animateTo(activeIndex);
                  }
                },),
            ),
            btns(label: '',icona: Icon(Icons.refresh),onclick: (){
              project();
            },)
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
                    padding: const EdgeInsets.only(top: 16.0,bottom: 15,left: 10),
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
                          padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                          child: Text('${clientdata['startDate']}',textAlign: TextAlign.start),
                        )
                    ),
                    Container(
                      width: 200,
                      // height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
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
                                        editDetails();
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
                                    GestureDetector(
                                      onTap: (){

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
