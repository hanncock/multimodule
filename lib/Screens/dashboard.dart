import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web3/responsive.dart';

import '../Constants/Theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding * 0.6),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding * 0.2),
                child: Row(
                  children: [
                    if(!Responsive.isDesktop(context))
                      IconButton(
                          onPressed: (){
                            print('tapped are we');

                          },
                        icon: Icon(Icons.menu,color: Colors.red,)
                    ),
                      Text('Dashboard',
                      style: header1,
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                    if(!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1,),
                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide:BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            suffixIcon: Container(
                              padding: EdgeInsets.all(defaultPadding * 0.75),
                              margin: EdgeInsets.symmetric(horizontal: defaultPadding/2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Icon(Icons.search,color: Colors.white,),
                            )
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                        vertical: defaultPadding /2
                      ),
                      margin: EdgeInsets.only(left: defaultPadding/2),
                      decoration: BoxDecoration(
                        // color: primaryColor,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person,size: 38,),
                          Text("Username ",
                            // style: TextStyle(
                            //   color: primaryfontColor,
                            // ),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.white
                              )
                            ),
                          ),
                          Icon(Icons.arrow_downward)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: defaultPadding,),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       flex: 5,
            //         child: Column(
            //           children: [
            //             Row(
            //               children: [
            //                 Text('My Files'),
            //                 Spacer(),
            //                 ElevatedButton.icon(
            //                   style: TextButton.styleFrom(
            //                     padding: EdgeInsets.symmetric(
            //                       horizontal: defaultPadding * 1.5,
            //                       vertical: defaultPadding
            //                     )),
            //                     onPressed: (){},
            //                     icon: Icon(Icons.add),
            //                   label: Text('New Add'),)
            //             ],),
            //             SizedBox(height: defaultPadding,),
            //             Responsive(
            //                 mobile: FileInfoCardGridView(
            //                   crossAxisCount: _size.width < 650 ? 2 : 4,
            //                 ),
            //                 tablet: FileInfoCardGridView(),
            //                 desktop: FileInfoCardGridView(
            //                   childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            //                 )
            //             ),
            //             if(Responsive.isMobile(context))
            //               SizedBox(height: defaultPadding,),
            //
            //             if(Responsive.isMobile(context))
            //               Container(
            //                 height: 500,
            //                 decoration: BoxDecoration(
            //                     color: secondaryColor,
            //                     borderRadius: BorderRadius.circular(10)
            //                 ),
            //                 child: Column(
            //                   children: [
            //                     Text('extra Details'),
            //                     SizedBox(
            //                       height: 200,
            //                       child: PieChart(
            //                           PieChartData(
            //                               sections: [
            //                                 PieChartSectionData(value: 15,color: Colors.red),
            //                                 PieChartSectionData(value: 15,color: Colors.green)
            //                               ]
            //                           )
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               )
            //           ],
            //         )
            //     ),
            //
            //     if(!Responsive.isMobile(context))
            //       SizedBox(width: defaultPadding,),
            //
            //     if(!Responsive.isMobile(context))
            //     Expanded(
            //       flex: 2,
            //         child: Container(
            //             height: 500,
            //             decoration: BoxDecoration(
            //                 color: secondaryColor,
            //                 borderRadius: BorderRadius.circular(10)
            //             ),
            //           child: Column(
            //             children: [
            //               Text('extra Details'),
            //               SizedBox(
            //                 height: 200,
            //                 child: PieChart(
            //                   PieChartData(
            //                     sections: [
            //                       PieChartSectionData(value: 15,color: Colors.red),
            //                       PieChartSectionData(value: 15,color: Colors.green)
            //                     ]
            //                   )
            //                 ),
            //               )
            //             ],
            //           ),
            //         )
            //     )
            //   ],
            // )


            Row(
              children: [

                Expanded(
                  flex: 4,
                    child: Container(
                      // height: 400,
                      decoration:BoxDecoration(
                        // color: secondaryColor,
                        borderRadius: BorderRadius.circular(10)
                      ) ,
                      child: Column(
                        children: [
                          Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Responsive(
                                    mobile: FileInfoCardGridView(
                                      crossAxisCount: _size.width < 650 ? 2 : 3,
                                    ),
                                    tablet: FileInfoCardGridView(),
                                    desktop: FileInfoCardGridView(
                                      childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                                    )
                                ),
                                if(Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding,),
                              ],
                            )
                          ),
                          SizedBox(height: defaultPadding,),
                          Container(
                            // height: 200,
                            decoration:BoxDecoration(
                                // color: secondaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                children:[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Payments',style: header2,),

                                      Card(
                                        // color: bgColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: defaultPadding * 0.9,
                                            right: defaultPadding * 0.9,
                                            top: defaultPadding * 0.4,
                                            bottom: defaultPadding * 0.4,
                                          ),
                                          child: Text('Full List',style: normal),
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(thickness: 0.1,color: Colors.black,),
                                  Row(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 200,
                                        // margin: const EdgeInsets.all(15.0),
                                        // padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.blueAccent)
                                        ),
                                        child: PieChart(
                                            PieChartData(
                                                sections: [
                                                  PieChartSectionData(value: 15,color: Colors.red),
                                                  PieChartSectionData(value: 15,color: Colors.green)
                                                ]
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context,index){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0,bottom: 6.0),
                                                  child: Text('List of all the items in use',style: normal,),
                                                ),
                                                Divider(color: Colors.black12,)
                                              ],
                                            );
                                          },
                                          itemCount: 6,
                                        ),
                                      )
                                    ],
                                  )
                                ]
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding,),
                          Container(
                            // height: 200,
                            decoration:BoxDecoration(
                                // color: secondaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                  children:[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Attendance',style: header2,),

                                        Card(
                                          // color: bgColor,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: defaultPadding * 0.9,
                                              right: defaultPadding * 0.9,
                                              top: defaultPadding * 0.4,
                                              bottom: defaultPadding * 0.4,
                                            ),
                                            child: Text('Full List',style: normal),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(thickness: 0.1,color: Colors.black,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 200,
                                          // margin: const EdgeInsets.all(15.0),
                                          // padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.blueAccent)
                                          ),
                                          // child:
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            Text('recent payments')
                                          ],
                                        ),

                                      ],
                                    ),
                                    if(Responsive.isMobile(context))
                                      // Text('soke'),
                                    SizedBox(height: defaultPadding,),

                                    if(Responsive.isMobile(context))
                                      extra_dash_details()
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                if(!Responsive.isMobile(context))
                SizedBox(width: defaultPadding,),

                if(!Responsive.isMobile(context))
                  Expanded(
                    flex: 4,
                    child: extra_dash_details()
                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}

class extra_dash_details extends StatelessWidget {
  const extra_dash_details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 500,
            decoration:BoxDecoration(
                // color: secondaryColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top Perfomer',style: header2,),

                      Card(
                        // color: bgColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: defaultPadding * 0.9,
                            right: defaultPadding * 0.9,
                            top: defaultPadding * 0.4,
                            bottom: defaultPadding * 0.4,
                          ),
                          child: Text('Full List',style: normal),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(thickness: 0.1,color: Colors.black,),
                Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(width: defaultPadding * 0.5,),
                                    Text('Here are the items',style: normal,),
                                  ],
                                ),
                                Divider(thickness: 0.1,color: Colors.black,)
                              ],
                            ),
                          );
                        }
                    )
                )
              ],
            ),
          ),
          SizedBox(height: defaultPadding * 0.6,),
          Container(
            // height: 200,
            decoration:BoxDecoration(
                // color: secondaryColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                  children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Schedule',style: header2,),

                        Card(
                          // color: bgColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: defaultPadding * 0.9,
                              right: defaultPadding * 0.9,
                              top: defaultPadding * 0.4,
                              bottom: defaultPadding * 0.4,
                            ),
                            child: Text('Full List',style: normal),
                          ),
                        )
                      ],
                    ),
                    Divider(thickness: 0.1,color: Colors.black,),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: defaultPadding,
                            mainAxisSpacing: defaultPadding,
                            crossAxisCount: 4,
                            childAspectRatio: 1.5
                        ),
                        itemBuilder: (context,index) => Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(child: Text('${index}',style: header2Dash,),),
                        )
                    )
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 200,
                    //       width: 200,
                    //       // margin: const EdgeInsets.all(15.0),
                    //       // padding: const EdgeInsets.all(3.0),
                    //       decoration: BoxDecoration(
                    //         // border: Border.all(color: Colors.blueAccent)
                    //       ),
                    //       child: PieChart(
                    //           PieChartData(
                    //               sections: [
                    //                 PieChartSectionData(value: 15,color: Colors.red),
                    //                 PieChartSectionData(value: 15,color: Colors.green)
                    //               ]
                    //           )
                    //       ),
                    //     ),
                    //     SizedBox(width: 10,),
                    //     Flexible(
                    //       child: ListView.builder(
                    //         shrinkWrap: true,
                    //         itemBuilder: (context,index){
                    //           return Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.only(top: 8.0,bottom: 6.0),
                    //                 child: Text('List of all the items in use',style: normal,),
                    //               ),
                    //               Divider(color: Colors.black12,)
                    //             ],
                    //           );
                    //         },
                    //         itemCount: 6,
                    //       ),
                    //     )
                    //   ],
                    // )
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio
        ),
        itemBuilder: (context,index) => Container(
          decoration: BoxDecoration(
            // color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
    );
  }
}
