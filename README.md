# web3

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


school
https://www.behance.net/gallery/112053835/School-Management-System?tracking_source=search_projects|school+system&l=11
https://www.behance.net/gallery/185861803/School-Management-Dashboard-UI-Design-I-Admin-Panel?tracking_source=search_projects|school+system&l=3
https://www.behance.net/gallery/161506911/School-managment-system-dashboard-design?tracking_source=search_projects|document+management+system&l=101


https://www.behance.net/gallery/197283259/LMS-e-learning-Dashboard?tracking_source=search_projects|school+management+system&l=21

crm
https://www.behance.net/gallery/180688701/CRM-DASHBOARD?tracking_source=search_projects|companies+list+system+crm&l=1
https://www.netsuite.com/portal/resource/articles/crm/crm-requirements.shtml
https://app.clickup.com/t/86bxk8c4n (sokesoke1072@gmail, Sokesoke1072)
https://dribbble.com/shots/22075972-Connecthub-CRM-Saas-Webapp-Dashboard

dms
https://www.behance.net/gallery/133691149/UI-Electronic-Document-Management-System?tracking_source=search_projects|document+management+system&l=1
https://www.behance.net/gallery/189448449/Document-management-system?tracking_source=search_projects|document+management+system&l=16




login
https://www.behance.net/gallery/191315701/netVerse?tracking_source=search_projects|login+ui+design&l=11


https://stackoverflow.com/questions/69244730/another-exception-was-thrown-assertion-failed-in-flutter

menu check
https://flutteragency.com/how-to-solve-automatickeepaliveclientmixin-is-not-working-with-bottomnavigationbar-in-flutter/


https://alphacode.medium.com/working-with-spreadsheets-in-flutter-part-2-a000fb3c49ef# multimodule

https://dribbble.com/shots/22130564-E-service-application-form
[autoloader.php](..%2F..%2FDesktop%2Fdamn%2Fsysschl%2Foop_php%2Foop3%2Fincludes%2Fautoloader.php)

check if i need to pass the userId when creating a company
checi if i need to return the last id if add a company then use that resposnse to add a user to that company[autoloader.php](..%2F..%2FDesktop%2Fdamn%2Fsysschl%2Foop_php%2Foop3%2Fincludes%2Fautoloader.php)


[autoloader.php](..%2F..%2FDesktop%2Fdamn%2Fsysschl%2Foop_php%2Foop3%2Fincludes%2Fautoloader.php)

https://ww5.gogoanimes.fi/super-cube-episode-1-18-episode-1

https://ww5.gogoanimes.fi/super-cube-episode-24
[index.php](..%2F..%2FDesktop%2Fdamn%2Fsysschl%2Foop_php%2FORM2%2Findex.php)

https://www.youtube.com/watch?v=uki8BS7xEug

https://www.youtube.com/watch?v=QPjeTSFhfP4

##acounting
https://www.youtube.com/watch?v=b93KBmcXanI&list=TLPQMjcwNTIwMjSyL4xelermxw&index=1

https://www.youtube.com/watch?v=qdO1hwg2HY8&list=PL5jb9EteFAOA3tCKoanOSEJaIDYn1Z5LC




import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
const DataTable2SimpleDemo();

@override
Widget build(BuildContext context) {
return Padding(
padding: const EdgeInsets.all(16),
child: DataTable2(
columnSpacing: 12,
horizontalMargin: 12,
minWidth: 600,
columns: [
DataColumn2(
label: Text('Column A'),
size: ColumnSize.L,
),
DataColumn(
label: Text('Column B'),
),
DataColumn(
label: Text('Column C'),
),
DataColumn(
label: Text('Column D'),
),
DataColumn(
label: Text('Column NUMBERS'),
numeric: true,
),
],
rows: List<DataRow>.generate(
100,
(index) => DataRow(cells: [
DataCell(Text('A' * (10 - index % 10))),
DataCell(Text('B' * (10 - (index + 5) % 10))),
DataCell(Text('C' * (15 - (index + 5) % 10))),
DataCell(Text('D' * (15 - (index + 10) % 10))),
DataCell(Text(((index + 0.1) * 25.4).toString()))
]))),
);
}
}