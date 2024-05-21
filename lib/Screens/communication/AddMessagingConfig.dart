import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Theme.dart';

class MessagingConfig extends StatefulWidget {
  const MessagingConfig({super.key});

  @override
  State<MessagingConfig> createState() => _MessagingConfigState();
}

class _MessagingConfigState extends State<MessagingConfig> {


  var usernanme;
  var password;
  var apiKey;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              forms(
                  label: "Username",
                  value: 'Username',
                  initVal: usernanme,
                  onChanged: (val){
                    setState(() {
                      usernanme = val;
                    });
                  }),
              forms(
                  label: 'Password',
                  value: 'Password',
                  initVal: password,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  }),
            ],
          ),
          // 41928f753d83cfa1c413d2ff71075de523f385b7b8a0a267b334353547ee8a6e
          forms(
            widthh: MediaQuery.of(context).size.width * 0.6,
            label: 'API Key',
              value: 'API Key',
              initVal: apiKey,
              onChanged: (val){
                setState(() {
                  apiKey = val;
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btns(
                label: 'Save',
                onclick: ()async{
                  Map data = {
                    "id":null,
                    "username":usernanme,
                    "password":password,
                    "apiKey":apiKey,
                    "companyId":companyIdInView
                  };
                  var resu = await auth.saveMany(data, "/api/communication/messagingsetup/add");
                  print(resu);
                  if(resu == 'success'){
                    Navigator.of(context).pop();
                  }else{
                    print('insert error');
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
