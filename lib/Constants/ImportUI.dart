import 'package:flutter/material.dart';

import '../Screens/crm/customers/importcustomers.dart';

upload(List? value,String todo,context,String? title,String? endpoint){
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
                    title: '${title ?? 'Import Sheet'}',
                    expectedVals: value,
                    endpoint: "/api${endpoint}",
                  ),
                  // child: detail == null? Card(child: AddCustomer()) : Card(child: AddCustomer(custDetails: [detail],)),
                  // child: CreateCompany(sessionStateStream: session, companyDetails: companyDetails,),
                ),
              );
            });
      });
}