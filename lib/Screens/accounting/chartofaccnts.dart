// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:web3/Constants/Reusableswidgets/btns.dart';
// import 'package:web3/Constants/Reusableswidgets/dropdown.dart';
// import 'package:web3/Constants/Reusableswidgets/textfield.dart';
// import 'package:web3/all_homes.dart';
// import '../../Constants/Theme.dart';
// import '../school/feesandcharges.dart';
// import 'getxcontroller.dart';
//
//
// class ChartodAccnts extends StatefulWidget {
//   const ChartodAccnts({super.key});
//
//   @override
//   State<ChartodAccnts> createState() => _ChartodAccntsState();
// }
//
// class _ChartodAccntsState extends State<ChartodAccnts> {
//
//   editDetails(var vals){
//     showDialog(
//         context: context,
//         builder: (BuildContext context){
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState){
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 300,vertical: 300),
//                   child: Card(
//                     child: Container(
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text('${vals['code']}',style: boldfont,),
//                                 SizedBox(width: 20,),
//                                 Text('${vals['headerName']}',style: boldfont,),
//                               ],
//                             ),
//                             Row(
//                               children: [
//
//                                 forms(
//                                     widthh: 150,
//                                     value: 'Sub Header Code',
//                                     hint: 'Sub Header Code i.e 101',
//                                     onChanged: (val){
//                                       setState(() {
//                                         subheaderCode = val;
//                                       });
//                                     }),
//                                 forms(
//                                     value: 'Sub Header',
//                                     hint: 'Sub-header i.e acc payable',
//                                     onChanged: (val){
//                                       setState(() {
//                                         subheader = val;
//                                       });
//                                     }),
//                                 dropdwn(
//
//                                     label: '',
//                                     values: ['Sub Header','Posting'], onChanged: (val){
//                                   setState((){
//                                     accType = val;
//                                   });
//                                 }),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   // mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(''),
//                                     btns(label: 'Add Sub-Header',
//                                         onclick: ()async{
//                                           Map moddata = {
//                                             "id":headerId,
//                                             "headerName":subheader,
//                                             "parentheader":vals['headerName'],
//                                             "code":subheaderCode,
//                                             "companyId":companyIdInView,
//                                             "accType":accType,
//                                             "parentheader2":subheader
//                                           };
//                                           print(moddata);
//                                           var resu = await auth.saveMany(moddata,'/api/accounting/accheader/add');
//                                           print(resu);
//                                           if(resu == 'success'){
//                                             Navigator.of(context).pop();
//                                           }
//                                         }
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               });
//         });
//   }
//
//   var headerId;
//   var header;
//   var headerCode;
//   var subheader;
//   var subheaderCode;
//   var accType;
//   List accs = [];
//   List updatedheads = [];
//
//   getHeaders()async{
//     var resu = await auth.getvalues('accounting/accheader/list?companyId=${companyIdInView}');
//     // print(resu);
//     for(int i =0; i<resu.length; i++){
//       if((resu[i]['parentheader'] == null) && (resu[i]['accType'] == 'header')){
//         Map<String, dynamic> mapval = {};
//         mapval[resu[i]['headerName']] = [];
//         var keys = updatedheads.map((map) => map.keys.first);
//         if(keys.contains(resu[i]['headerName'])){
//
//         }else{
//           updatedheads.add(mapval);
//           // print("newly updated heads${updatedheads}");
//         }
//         }else{
//
//         var keys = updatedheads.map((map) => map.keys.first);
//         // print("other values${keys.toList().indexWhere((element) => element == resu[i]['parentheader'])}");
//         var ind = keys.toList().indexWhere((element) => element == resu[i]['parentheader']);
//         var headName = resu[i]['parentheader'];
//         // print("newly updated heads ${updatedheads}");
//         updatedheads[ind][headName].add(resu[i]);
//       }
//     }
//     // print("here are the excempted${updatedheads}");
//
//     setState(() {
//       accs = resu;
//     });
//     // print(accs);
//   }
//
//
//
//   @override
//   void initState(){
//     super.initState();
//     getHeaders();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TapController tapController = Get.put(TapController());
//
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Row(
//                 children: [
//                   forms(
//                     widthh: 150,
//                       value: 'Header Code',
//                       hint: 'Acc Header Code i.e 101',
//                       onChanged: (val){
//                         setState(() {
//                           headerCode = val;
//                         });
//                       }),
//                   forms(
//                       value: 'Header',
//                       hint: 'Acc Header i.e Assets',
//                       onChanged: (val){
//                         setState(() {
//                           header = val;
//                         });
//                       }),
//                   Column(
//                     children: [
//                       Text(''),
//                       btns(
//                         label: 'Add Header',
//                         onclick: ()async{
//                           Map moddata = {
//                             "id":headerId,
//                             "headerName":header,
//                             "code":headerCode,
//                             "companyId":companyIdInView,
//                           };
//                           print(moddata);
//                           var resu = await auth.saveMany(moddata,'/api/accounting/accheader/add');
//                           print(resu);
//                         },
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               IconButton(onPressed: (){
//                 getHeaders();
//               }, icon: Icon(Icons.refresh,color: Colors.green,))
//
//             ],
//           ),
//           Container(
//             child: Column(
//               children: [
//
//                 ListView.builder(
//                     shrinkWrap:true,
//                     itemCount: updatedheads.length,
//                     itemBuilder: (context,index){
//                       var header = updatedheads[index];
//                       var title = header.keys.first;
//                       var indx = accs.indexWhere((element) => element['headerName'] == title);
//                   return Container(
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.black12,
//                           width: 1
//                         )
//                       )
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('${header.keys.first}',style: boldfont,),
//                               (accs[indx]['accType'] == 'header') ? Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50),
//                                     color: Colors.green.withOpacity(0.1)
//                                 ),
//                                 child: IconButton(onPressed: (){
//                                   editDetails(accs[index]);
//                                 }, icon: Icon(Icons.add,color: Colors.green,)),
//                               ):SizedBox()
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             ListView.builder(
//                               itemCount: header[title].length,
//                                 shrinkWrap:true,
//                                 itemBuilder: (context, ind){
//                                 var subhead = header[title][ind];
//                               return Padding(
//                                 padding: const EdgeInsets.only(left: 20.0,top: 5),
//                                 child: subhead['accType'] == 'subheader'?
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 22.0,top: 5),
//                                   child: Text('${subhead['headerName']}',style: boldfont,),
//                                 ):
//                                 GestureDetector(
//                                   onTap: (){
//                                     if(tapController.openScreenstitlles.contains(subhead['headerName'])){
//                                       tapController.printList();
//                                       tapController.switchTo(subhead['headerName']);
//                                       print('contains and switching ${tapController.actvTab}');
//                                     }else{
//                                       tapController.printList();
//                                       tapController.addtoList(subhead['headerName'],FessandCharges());
//
//                                     }
//
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 22.0,top: 5),
//                                     child: Text('${subhead['headerName']}',style: TextStyle(color: Colors.blue),),
//                                   ),
//                                 ),
//                               );
//                             })
//                           ],
//                         )
//                       ],
//                     ),
//                   );
//                 })
//
//                 // ListView.builder(
//                 //   itemCount: accs.length,
//                 //   shrinkWrap: true,
//                 //   itemBuilder: (context, index){
//                 //     return Container(
//                 //       decoration: BoxDecoration(
//                 //         borderRadius: BorderRadius.circular(10),
//                 //         border: Border.all(width: 0.1,color: Colors.black12)
//                 //       ),
//                 //         child: Padding(
//                 //           padding: const EdgeInsets.all(12.0),
//                 //           child: Row(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               Text('${accs[index]['headerName']}',style: TextStyle(color: Colors.blue),),
//                 //               (accs[index]['accType'] == 'header' || accs[index]['accType'] == 'subheader') ? Container(
//                 //                 decoration: BoxDecoration(
//                 //                   borderRadius: BorderRadius.circular(50),
//                 //                   color: Colors.green.withOpacity(0.1)
//                 //                 ),
//                 //                 child: IconButton(onPressed: (){
//                 //                   editDetails(accs[index]);
//                 //                 }, icon: Icon(Icons.add,color: Colors.green,)),
//                 //               ):SizedBox()
//                 //             ],
//                 //           ),
//                 //         ));
//                 //   },
//                 // ),
//
//
// //
//               ],
//             ),
//           ),
//           // Text('${updatedheads}'),
//           // Container(
//           //   child: Column(
//           //     children: [
//           //       ListView.builder(
//           //         shrinkWrap: true,
//           //           itemCount:accs.length,
//           //           itemBuilder: (context,index){
//           //         if(accs[index]['accType'] == 'header') {
//           //           return Container(
//           //               child: Column(
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: [
//           //                   Text('${accs[index]['headerName']}'),
//           //                   Padding(
//           //                     padding: const EdgeInsets.only(left: 10),
//           //                     child: Column(
//           //                       children:
//           //                         _buildChildren(accs[index]['headerName']),
//           //
//           //                       // ],
//           //                     ),
//           //                   ),
//           //                 ],
//           //               ));
//           //         }else{
//           //           // return Text('${accs[index]['headerName']}');
//           //           return SizedBox();
//           //         }
//           //       }),
//           //       Text("${accs}")
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildChildren(String parentHeader) {
//     List<Widget> children = [];
//
//     for (var item in accs) {
//       if (item['parentheader'] == parentHeader) {
//         if (item['accType'] == 'header') {
//           children.add(ExpansionTile(
//             title: Text(item['headerName']),
//             children: _buildChildren(item['headerName']),
//           ));
//         } else {
//           children.add(ListTile(
//             title: Text(item['headerName']),
//           ));
//         }
//       }
//     }
//
//     return children;
//   }
//
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/dropdown.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';
import '../../Constants/Theme.dart';
import '../school/feesandcharges.dart';
import 'getxcontroller.dart';


class ChartodAccnts extends StatefulWidget {
  const ChartodAccnts({super.key});

  @override
  State<ChartodAccnts> createState() => _ChartodAccntsState();
}

class _ChartodAccntsState extends State<ChartodAccnts> {

  editDetails(var vals){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300,vertical: 300),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('${vals['code']}',style: boldfont,),
                                SizedBox(width: 20,),
                                Text('${vals['headerName']}',style: boldfont,),
                              ],
                            ),
                            Row(
                              children: [

                                forms(
                                    widthh: 150,
                                    value: 'Sub Header Code',
                                    hint: 'Sub Header Code i.e 101',
                                    onChanged: (val){
                                      setState(() {
                                        subheaderCode = val;
                                      });
                                    }),
                                forms(
                                    value: 'Sub Header',
                                    hint: 'Sub-header i.e acc payable',
                                    onChanged: (val){
                                      setState(() {
                                        subheader = val;
                                      });
                                    }),
                                dropdwn(

                                    label: '',
                                    values: ['Sub Header','Posting'], onChanged: (val){
                                  setState((){
                                    accType = val;
                                  });
                                }),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(''),
                                    btns(label: 'Add Sub-Header',
                                        onclick: ()async{
                                          Map moddata = {
                                            "id":headerId,
                                            "headerName":subheader,
                                            "parentheader":vals['headerName'],
                                            "code":subheaderCode,
                                            "companyId":companyIdInView,
                                            "accType":accType,
                                            "parentheader2":subheader
                                          };
                                          print(moddata);
                                          var resu = await auth.saveMany(moddata,'/api/accounting/accheader/add');
                                          print(resu);
                                          if(resu == 'success'){
                                            Navigator.of(context).pop();
                                          }
                                        }
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  var headerId;
  var header;
  var headerCode;
  var subheader;
  var subheaderCode;
  var accType;
  List accs = [];
  List updatedheads = [];

  getHeaders()async{
    var resu = await auth.getvalues('accounting/accheader/list?companyId=${companyIdInView}');
    // print(resu);
    for(int i =0; i<resu.length; i++){
      if((resu[i]['parentheader'] == null) && (resu[i]['accType'] == 'header')){
        Map<String, dynamic> mapval = {};
        mapval[resu[i]['headerName']] = [];
        var keys = updatedheads.map((map) => map.keys.first);
        if(keys.contains(resu[i]['headerName'])){

        }else{
          updatedheads.add(mapval);
          // print("newly updated heads${updatedheads}");
        }
      }else{

        var keys = updatedheads.map((map) => map.keys.first);
        // print("other values${keys.toList().indexWhere((element) => element == resu[i]['parentheader'])}");
        var ind = keys.toList().indexWhere((element) => element == resu[i]['parentheader']);
        var headName = resu[i]['parentheader'];
        // print("newly updated heads ${updatedheads}");
        updatedheads[ind][headName].add(resu[i]);
      }
    }
    // print("here are the excempted${updatedheads}");

    setState(() {
      accs = resu;
    });
    // print(accs);
  }



  @override
  void initState(){
    super.initState();
    getHeaders();
  }

  @override
  Widget build(BuildContext context) {
    TapController tapController = Get.put(TapController());

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  forms(
                      widthh: 150,
                      value: 'Header Code',
                      hint: 'Acc Header Code i.e 101',
                      onChanged: (val){
                        setState(() {
                          headerCode = val;
                        });
                      }),
                  forms(
                      value: 'Header',
                      hint: 'Acc Header i.e Assets',
                      onChanged: (val){
                        setState(() {
                          header = val;
                        });
                      }),
                  Column(
                    children: [
                      Text(''),
                      btns(
                        label: 'Add Header',
                        onclick: ()async{
                          Map moddata = {
                            "id":headerId,
                            "headerName":header,
                            "code":headerCode,
                            "companyId":companyIdInView,
                          };
                          print(moddata);
                          var resu = await auth.saveMany(moddata,'/api/accounting/accheader/add');
                          print(resu);
                        },
                      ),
                    ],
                  )
                ],
              ),
              IconButton(onPressed: (){
                getHeaders();
              }, icon: Icon(Icons.refresh,color: Colors.green,))

            ],
          ),
          Container(
            child: Column(
              children: [

                ListView.builder(
                    shrinkWrap:true,
                    itemCount: updatedheads.length,
                    itemBuilder: (context,index){
                      var header = updatedheads[index];
                      var title = header.keys.first;
                      var indx = accs.indexWhere((element) => element['headerName'] == title);
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black12,
                                    width: 1
                                )
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${header.keys.first}',style: boldfont,),
                                  (accs[indx]['accType'] == 'header') ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green.withOpacity(0.1)
                                    ),
                                    child: IconButton(onPressed: (){
                                      editDetails(accs[index]);
                                    }, icon: Icon(Icons.add,color: Colors.green,)),
                                  ):SizedBox()
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ListView.builder(
                                    itemCount: header[title].length,
                                    shrinkWrap:true,
                                    itemBuilder: (context, ind){
                                      var subhead = header[title][ind];
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 20.0,top: 5),
                                        child: subhead['accType'] == 'subheader'?
                                        Padding(
                                          padding: const EdgeInsets.only(left: 22.0,top: 5),
                                          child: Text('${subhead['headerName']}',style: boldfont,),
                                        ):
                                        GestureDetector(
                                          onTap: (){
                                            if(tapController.openScreenstitlles.contains(subhead['headerName'])){
                                              tapController.switchTo(subhead['headerName']);
                                              DefaultTabController.of(context).animateTo(tapController.actvTab);
                                            }else{
                                              tapController.printList();
                                              tapController.addtoList(subhead['headerName'],FessandCharges());
                                              tapController.switchTo(subhead['headerName']);
                                              DefaultTabController.of(context).animateTo(tapController.actvTab);

                                            }

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 22.0,top: 5),
                                            child: Text('${subhead['headerName']}',style: TextStyle(color: Colors.blue),),
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            )
                          ],
                        ),
                      );
                    })

                // ListView.builder(
                //   itemCount: accs.length,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index){
                //     return Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         border: Border.all(width: 0.1,color: Colors.black12)
                //       ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text('${accs[index]['headerName']}',style: TextStyle(color: Colors.blue),),
                //               (accs[index]['accType'] == 'header' || accs[index]['accType'] == 'subheader') ? Container(
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(50),
                //                   color: Colors.green.withOpacity(0.1)
                //                 ),
                //                 child: IconButton(onPressed: (){
                //                   editDetails(accs[index]);
                //                 }, icon: Icon(Icons.add,color: Colors.green,)),
                //               ):SizedBox()
                //             ],
                //           ),
                //         ));
                //   },
                // ),


//
              ],
            ),
          ),
          // Text('${updatedheads}'),
          // Container(
          //   child: Column(
          //     children: [
          //       ListView.builder(
          //         shrinkWrap: true,
          //           itemCount:accs.length,
          //           itemBuilder: (context,index){
          //         if(accs[index]['accType'] == 'header') {
          //           return Container(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text('${accs[index]['headerName']}'),
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 10),
          //                     child: Column(
          //                       children:
          //                         _buildChildren(accs[index]['headerName']),
          //
          //                       // ],
          //                     ),
          //                   ),
          //                 ],
          //               ));
          //         }else{
          //           // return Text('${accs[index]['headerName']}');
          //           return SizedBox();
          //         }
          //       }),
          //       Text("${accs}")
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  List<Widget> _buildChildren(String parentHeader) {
    List<Widget> children = [];

    for (var item in accs) {
      if (item['parentheader'] == parentHeader) {
        if (item['accType'] == 'header') {
          children.add(ExpansionTile(
            title: Text(item['headerName']),
            children: _buildChildren(item['headerName']),
          ));
        } else {
          children.add(ListTile(
            title: Text(item['headerName']),
          ));
        }
      }
    }

    return children;
  }

}
