import 'package:flutter/material.dart';
import 'package:web3/Constants/Reusableswidgets/btns.dart';
import 'package:web3/Constants/Reusableswidgets/textfield.dart';
import 'package:web3/all_homes.dart';

import '../../Constants/Reusableswidgets/dropdown.dart';
import '../../Constants/Theme.dart';
import '../../Constants/calender.dart';

class AddStream extends StatefulWidget {
  final List? dets;
  const AddStream({super.key, this.dets});

  @override
  State<AddStream> createState() => _AddStreamState();
}

class _AddStreamState extends State<AddStream> {

  late var id = widget.dets?[0]['id'];
  late var name = widget.dets?[0]['streamName'];
  late var code = widget.dets?[0]['streamCode'];
  // late var endDate = widget.dets?[0]['endDate'];
  // late var shrtform = widget.dets?[0]['shrtfrm'];

  List streams = [];
  getStreams()async{
    var resu = await auth.getvalues("school/stream/list?companyId=${companyIdInView}");
    print(resu);
    streams = resu;
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getStreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: btns(label: 'Streams'))
            ],
          ),
          Divider(thickness: 0.5,),
          Row(
            children: [
              forms(
                  value: name,
                  initVal: name,
                  label: 'Stream Name',
                  hint: "Stream Name",
                  onChanged: (value){
                    setState(() {
                      name = value;
                    });
                  }),
              forms(
                  value: code,
                  initVal: code,
                  label: 'Stream code',
                  hint: "code",
                  onChanged: (value){
                    setState(() {
                      code = value;
                    });
                  }),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btns(label: 'Add Stream',color: Colors.green,onclick: ()async{

                    Map data = {
                      "id":id,
                      "streamName" : name,
                      "streamCode" : code,
                      // "endDate" : endDate,
                      // "shrtfrm" : shrtform,
                      "companyId" : companyIdInView
                    };
                    var resu = await auth.saveMany(data,"/api/school/stream/add");
                    print(resu);
                    if(resu == 'success'){
                      // Navigator.of(context).pop();
                    }else{
                      print('none');
                    }
                  },)
                ],
              ),
            ],
          ),
          Divider(color: Colors.black12,height: 0.5,),
          Container(
            child: Column(
                children: [
                  ListView.builder(
                      itemCount: streams.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${streams[index]['streamName']}'),
                          ),
                        );
                      })
                ]
            ),
          )

        ],
      ),
    );
  }
}
