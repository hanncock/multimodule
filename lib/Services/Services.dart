import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Wrapper.dart';
import 'User.dart';


class AuthService{

  // String url ="http://192.168.0.111:3000";
  // String url ="http://192.168.1.117:3000";
  // String url ="http://192.168.100.19:3000";
  String url ="http://192.168.1.102:3000";

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };


  login(username,password)async{

    var all = '$url/api/users/login';
    Map data = {
      "email": username,
      "pass": password
    };
    var send = jsonEncode(data);

    print(send);

    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    print('here is ${response.body} jj');
    var responseData = jsonDecode(response.body);
    if(responseData['success'] == true){

      var creds = [username,password];
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Userdata", jsonEncode(responseData['data']));
      pref.setString("userCreds", jsonEncode(creds));
      return(User.fromJson(responseData['data']));
    }else {
      return responseData;
    }
  }

  getclients()async{
    String getcompanies = "$url/api/client/list";
    print(getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }

  createCust(id,clientName,clientEmail,clientPhone,contPersonName,contPersonPhone,referral,location,postalAdd,industry,custType)async{

    var all = '$url/api/client/add';
    Map data = {
        "clientId":id,
        "clientName":clientName,
        "clientEmail":clientEmail,
        "clientPhone":clientPhone,
        "contPersonName":contPersonName,
        "contPersonPhone":contPersonPhone,
        "referral":referral,
        "industry":industry,
        "clientType":custType,
        "location":location,
        "postalAdd":postalAdd
  };
    var send = jsonEncode(data);
    print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return responseData;
  }


  saveMany(val)async{
    var all = '$url/api/client/add';
    // print(val);
    var send = jsonEncode(val);
    // print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    print(" response is ${responseData}");
    // return responseData;
  }


  createProj(id,projectName,projDescription,personInCharge,inchargeMail,inchargeContact,startdate,enddate,projectStatus,designation)async{

    var all = '$url/api/project/add';
    Map data = {
      "projectId":id,
      "projectName":projectName,
      "projDescription":projDescription,
      "personInCharge":personInCharge,
      "inchargeMail":inchargeMail,
      "startDate":startdate,
      "endDate":enddate,
      "projectStatus":projectStatus,
      "designation":designation,
      // "location":location,
      // "postalAdd":postalAdd
    };
    var send = jsonEncode(data);
    print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    print(responseData);

  }

  getProjects()async{
    String getcompanies = "$url/api/project/list";
    print(getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }

  createProjCol(id,projectColName)async{

    var all = '$url/api/project/add';
    Map data = {
      "projColId":id,
      "projColName":projectColName,
    };
    var send = jsonEncode(data);
    print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    print(responseData);

  }

  getProjectsColumns()async{
    String getcompanies = "$url/api/project/list";
    print(getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }


}