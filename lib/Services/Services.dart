import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/all_homes.dart';
import 'User.dart';


class AuthService{

  // String url ="http://192.168.0.111:3000";
  String url ="http://0.0.0.0:3000";
  // String url ="https://106e-41-209-57-162.ngrok-free.app";

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

  getvalues(endpoint)async{
    var fetchedData = "$url/api/$endpoint";
    print(fetchedData);
    try{
      var response =  await get(Uri.parse(fetchedData));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }



  saveMany(val,endpoint)async{
    var all = '${url}${endpoint}';
    var send = jsonEncode(val);
    // print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    return responseData;
  }




  getclients(var projId)async{
    // String getcompanies = "$url/api/client/list?companyId=${companyIdInView}"+projId == null ? "" :"&projectId = ${projId.toString()}" ;
    String getcompanies ;

    projId == null ?  getcompanies = "$url/api/client/list?companyId=${companyIdInView}":
        getcompanies = "$url/api/client/list?companyId=${companyIdInView}&projectId=${projId}";
    // print("here are thr resposnses "+getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }




  delete(id,endpoinr)async{
    String res = "$url/api$endpoinr";
    Map data = {"id": id,};
    var response = await http.post(Uri.parse(res), body: jsonEncode(data), headers: headers);
    var responseData = jsonDecode(response.body);
    return responseData;
  }

  getUsers()async{
    String getcompanies = "$url/api/user/list";
    print(getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }

  getcompany()async{
    String getcompanies = "$url/api/company/list";
    print(getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }

  createCust(id,clientName,clientEmail,clientPhone,contPersonName,contPersonPhone,referral,location,postalAdd,industry,custType,leadId,projectId)async{

    var all = '$url/api/client/add';
    Map data = {
        "id":id,
        "clientName":clientName,
        "clientEmail":clientEmail,
        "clientPhone":clientPhone,
        "contPersonName":contPersonName,
        "contPersonPhone":contPersonPhone,
        "referral":referral,
        "industry":industry,
        "clientType":custType,
        "location":location,
        "postalAdd":postalAdd,
        "companyId":companyIdInView,
        "leadId":leadId,
        "projectId":projectId,
  };
    var send = jsonEncode(data);
    print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return responseData;
  }


  createProj(id,projectName,projDescription,personInCharge,inchargeMail,inchargeContact,startdate,enddate,projectStatus,designation)async{

    var all = '$url/api/project/add';
    Map data = {
      "id":id,
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
    // print(send);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    return responseData;
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

  getRequests(endpoint)async{
    String getcompanies = "$url/api/${endpoint}";
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
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }

  getStudents()async{
    // String getcompanies = "$url/api/client/list?companyId=${companyIdInView}"+projId == null ? "" :"&projectId = ${projId.toString()}" ;
    String getcompanies = "$url/api/student/list?companyId=${companyIdInView}";
    print("here are thr resposnses "+getcompanies);
    try{
      var response =  await get(Uri.parse(getcompanies));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }



}