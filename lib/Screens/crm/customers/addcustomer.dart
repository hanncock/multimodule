import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Constants/Reusableswidgets/btns.dart';
import '../../../Constants/Reusableswidgets/dropdown.dart';
import '../../../Constants/Reusableswidgets/textfield.dart';
import '../../../Constants/Theme.dart';

class AddCustomer extends StatefulWidget {
  final List? custDetails;
  const AddCustomer({Key? key,this.custDetails}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {




  late var id =  widget.custDetails?[0]['id'];
  late var clientName = widget.custDetails?[0]['clientName'];
  late var clientEmail = widget.custDetails?[0]['clientEmail'];
  late var clientPhone = widget.custDetails?[0]['clientPhone'];
  late var contPersonName = widget.custDetails?[0]['contPersonName'];
  late var contPersonPhone = widget.custDetails?[0]['contPersonPhone'];
  late var referral = widget.custDetails?[0]['referral'];
  late var location = widget.custDetails?[0]['location'];
  late var postalAdd = widget.custDetails?[0]['postalAdd'];
  late var industry = widget.custDetails?[0]['industry'];
  late var custType = widget.custDetails?[0]['clientType'];


  @override
  Widget build(BuildContext context) {
    print(widget.custDetails);
    return Container(
      height: 500,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
      
            children: [
              Row(
                children: [
                  Expanded(child: btns(label: 'Add Customer'))
                  // Text('Add Customer'),
                ],
              ),
              Divider(thickness: 0.5,),
              SizedBox(height: 20,),
              Row(
                children: [
                  Column(
                    children: [
                      forms(value: clientName,
                        initVal: clientName,
                        label: 'Name / Company',
                        widthh: 400,
                        hint: 'name',
                        onChanged: (val) { setState(() {
                          clientName =val;
                      }); },),

                    ],
                  ),
                  Column(
                    children: [
                      forms(value: clientEmail,
                        initVal: clientEmail,
                        label: 'Email', hint: 'mail@example.com', onChanged: (val) {setState(() {
                        clientEmail = val;
                      });},),

                    ],
                  ),
                  Column(
                    children: [
                      forms(value: clientPhone,
                        initVal: clientPhone.toString(),
                        label: 'Phone Number', hint: '+000-000-000-000',onChanged: (val){
                        setState(() {
                          clientPhone = val;
                        });
                      },)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      dropdwn(
                        label: 'Customer Type',
                        values: ['Individual','Enterprise','School','Company'],
                        onChanged: (String? value) {
                          setState(() {
                            custType = value;
                          });
                        },
                        selectedval: custType,)
                    ],
                  ),
                  SizedBox(width: 100,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          forms(value: contPersonName,
                            initVal: contPersonName,
                            label: 'Contact Person name',hint: 'Conatct Person Name',
                            onChanged: (val) {
                              setState(() {
                                contPersonName = val;
                              });
                            },)
                        ],
                      ),
                      Column(
                        children: [
                          forms(value: contPersonPhone,
                            initVal: contPersonPhone,
                            label: 'Conatct Person Phone', hint: '+000-000-000-000', onChanged: (val) {setState(() {
                            contPersonPhone = val;
                          });  },)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          forms(value: postalAdd,
                            initVal: postalAdd,
                            label: 'Postal Address', hint: '124-Nairobi', onChanged: (String value) {
                            postalAdd = value;
                          },)
                        ],
                      ),
                      Column(
                        children: [
                          forms(value: location,
                            initVal: location,
                            label: 'Location', hint: 'Location', onChanged: (String value) {
                            setState(() {
                              location = value;
                            });
                          },)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
      
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
      
                    children: [
                      dropdwn(label: 'Industry', values: ['Manufacturing','Construction'],
                        onChanged: (String? value) {
                          setState(() {
                            industry =value;
                          });
                        }, selectedval: industry,)
                    ],
                  ),
                  SizedBox(width: 100,),
                  Column(
                    children: [
                      forms(value: referral,
                        initVal: referral,
                        label: 'Reffered by', hint: 'Reffered by', onChanged: (String value) {
                        setState(() {
                          referral = value;
                        });
                      },)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Divider(color: Colors.black12,height: 0.5,),
              SizedBox(height: 30,),
              // Text('${widget.custDetails}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btns(label: 'Create Customer',color: Colors.green,onclick: ()async{
                    var resu = await auth.createCust(id, clientName, clientEmail, clientPhone, contPersonName, contPersonPhone, referral, location, postalAdd, industry, custType);
                    if(resu == 'success'){
                      Navigator.of(context).pop();
                    }else{
                      print('none');
                    }
                    // print('Creating User');
                  },)
                ],
              )
            ],
          ),
      ),
    );
  }
}
