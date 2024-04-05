import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Screens/crm/customers/customers.dart';
import 'package:web3/allHomes/all_homes.dart';
import 'Login/login.dart';


class Wrapper extends StatefulWidget {

  final StreamController<SessionState> sessionStateStream;
  const Wrapper({Key? key,required this.sessionStateStream}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

var session;
var Userdata ;


class _WrapperState extends State<Wrapper> {

  checkValues()async{
    SharedPreferences user = await SharedPreferences.getInstance();
    var data = user.getString('Userdata');
    setState(() {
      session = widget.sessionStateStream;
    });

    if(data == null){
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  Login(sessionStateStream: widget.sessionStateStream,)));

    }else{

      setState(() {
        Userdata = jsonDecode(data);
        // currentUser = "${Userdata['firstName']} ${Userdata['otherNames']}";
      });


      // flutter how to make a tab not refresh its state
      widget.sessionStateStream.add(SessionState.stopListening);
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  AllHomes(sessionStateStream: widget.sessionStateStream,)));
      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  widtest()));
      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Login(sessionStateStream: widget.sessionStateStream,)));
      widget.sessionStateStream.add(SessionState.startListening);

    }

  }

  @override
  void initState() {
    checkValues();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
