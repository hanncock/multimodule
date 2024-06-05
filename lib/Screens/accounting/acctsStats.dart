import 'package:flutter/material.dart';

class AccntStats extends StatefulWidget {
  const AccntStats({super.key});

  @override
  State<AccntStats> createState() => _AccntStatsState();
}

class _AccntStatsState extends State<AccntStats> {
  @override
  Widget build(BuildContext context) {
    var contWidth = MediaQuery.of(context).size.width -250;

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.all(2),
                width: contWidth/6,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: Colors.green)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text('Assets')),
                ),
              ),
              Container(
                width: contWidth/6,
                margin: EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.red
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text('Liabilities')),
                ),
              ),
              Container(
                width: contWidth/6,
                margin: EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.grey
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text('Equity')),
                ),
              ),
              Container(
                width: contWidth/6,
                margin: EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.yellow
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text('Dividents')),
                ),
              ),
              Container(
                width: contWidth/6,
                margin: EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.1),
                    border: Border.all(width: 1,color: Colors.black
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text('Expenses')),
                ),
              ),
              Container(
                width: contWidth/6,
                margin: EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.withOpacity(0.1),
                    border: Border.all(width: 1,color: Colors.blue
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text('Revenue')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
