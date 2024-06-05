import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Theme.dart';
import 'AddMessagingConfig.dart';

class Messaging extends StatefulWidget {
  const Messaging({super.key});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {

  List config = [];
  List messages = [];
  var phones;
  var messo;
  var searchnum;
  var searchmesso;

  getMessoConfig()async{
    var resu = await auth.getvalues('communication/messagingsetup/list?companyId=${companyIdInView}');
    config = resu;
    // setState(() {});
  }

  getMessages()async{
    var resu = await auth.getvalues('communication/message/list?companyId=${companyIdInView}');
    messages = resu;
    // setState(() {});
  }

  editDetails(){
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
                      child: MessagingConfig(),
                    ),
                  ),
                );
              });
        });
  }


  @override
  void initState(){
    super.initState();
    getMessoConfig();
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        forms(
                            // label: 'Number',
                            onChanged: (val){
                    
                            },
                            value: searchnum ?? 'number',
                          ),
                        forms(
                            // label: 'Message',
                            value: searchmesso ?? 'message',
                            onChanged: (val){
                              searchmesso = val;
                            })
                        // ),
                      ],
                    ),
                  ),
                  btns(label:'Setup Messaging',
                    onclick: (){
                      editDetails();
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    children: <Widget>[
                      // _buildStaticHeader(), // Static header
                      _buildStaticHeader(
                        ['Recipient','Message','Status','Cost','User']
                      ), // Static header
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: List.generate(
                            messages.length,
                                (index){
                              var item = messages[index];
                                  return ListTile(
                                    title: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom:BorderSide(color: Colors.black12,
                                                  width: 0.5
                                              )
                                          )
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text('${item['numberTo']}')),
                                          Expanded(child: Text('${item['message']}')),
                                          Expanded(child: Text('${item['status']}')),
                                          Expanded(child: Text('${item['cost']}')),
                                          Expanded(child: Text('${item['user']}')),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      forms(value: phones,
                          onChanged: (val){
                            phones = val;
                          }),
                      forms(value: messo,
                          onChanged: (val){
                            messo = val;
                          }),
                      btns(label: 'Send',
                        onclick: ()async{
                          var resu = await auth.sendSms(phones, messo, config[0]['username'],config[0]['apiKey']);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}
Widget _buildStaticHeader(List headers) {
  return Container(
    color: Colors.grey[300],
    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
    child: Row(
      children: List.generate(headers.length, (index) => Expanded(child: Text('${headers[index]}',style: boldfont,))),
    ),
  );
}