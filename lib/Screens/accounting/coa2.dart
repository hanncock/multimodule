import 'package:flutter/material.dart';

class NestedListView extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  NestedListView({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data[index]['accType'] == 'header') {
          return ExpansionTile(
            title: Text(data[index]['headerName']),
            children: _buildChildren(data[index]['headerName']),
          );
        } else {
          return ListTile(
            title: Text(data[index]['headerName']),
          );
        }
      },
    );
  }

  List<Widget> _buildChildren(String parentHeader) {
    List<Widget> children = [];

    for (var item in data) {
      if (item['parentheader'] == parentHeader) {
        if (item['accType'] == 'header') {
          children.add(ExpansionTile(
            title: Text(item['headerName']),
            children: _buildChildren(item['headerName']),
          ));
        } else {
          children.add(ListTile(
            title: Text(item['headerName']),
          ));
        }
      }
    }

    return children;
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Nested List View'),
      ),
      body: NestedListView(
        data: [
          // Your data here
          // For example:
          {"headerName": "Assets", "parentheader": null, "accType": "header"},
          {"headerName": "Current Assets", "parentheader": "Assets", "accType": "subheader"},
          {"headerName": "CASH", "parentheader": "Assets", "accType": "subheader"},
          {"headerName": "Other Asset", "parentheader": "Assets", "accType": "header"},
          {"headerName": "Sub Asset", "parentheader": "Other Asset", "accType": "subheader"},
          {"headerName": "Dividends", "parentheader": null, "accType": "header"},
          {"headerName": "Owners", "parentheader": "Dividends", "accType": "header"},
          {"headerName": "Expenses", "parentheader": null, "accType": "header"},
          {"headerName": "Liabilities", "parentheader": null, "accType": "header"},
          {"headerName": "Equity", "parentheader": null, "accType": "header"},
          {"headerName": "Revenue", "parentheader": null, "accType": "header"},
        ],
      ),
    ),
  ));
}