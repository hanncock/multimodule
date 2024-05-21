import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Theme.dart';

class Mailconfig extends StatefulWidget {
  const Mailconfig({super.key});

  @override
  State<Mailconfig> createState() => _MailconfigState();
}

class _MailconfigState extends State<Mailconfig> {


  var usernanme;
  var password;
  var smtpHost;
  var port;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
              Row(
                children: [
                  forms(
                      label: 'SMTP Host',
                      value: 'SMTP Host',
                      initVal: smtpHost,
                      onChanged: (val){
                        setState(() {
                          smtpHost = val;
                        });
                      }),
                  forms(
                      label: 'Port',
                      value: 'Port',
                      initVal: port,
                      onChanged: (val){
                        setState(() {
                          port = val;
                        });
                      }),
                ],
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: btns(
                  label: 'Save',
                  onclick: ()async{
                    Map data = {
                      "id":null,
                      "username":usernanme,
                      "password":password,
                      "smtpHost":smtpHost,
                      "port":port,
                      "companyId":companyIdInView
                    };
                    var resu = await auth.saveMany(data, "/api/communication/emailsetup/add");
                    print(resu);
                    if(resu == 'success'){
                      Navigator.of(context).pop();
                    }else{
                      print('insert error');
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
