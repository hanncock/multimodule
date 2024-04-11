// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:web3/Screens/crm/Leads/Leads.dart';
// import '../../Constants/Theme.dart';
// import '../../allHomes/all_homes.dart';
// import '../../custom_display/keepAlive.dart';
//
// List openScreenstitles = ['Dashboard'];
// final openScreensWidgets = <dynamic>[Leads()];
// late TabController controller2;
//
// class ScreenDisp extends StatefulWidget {
//   final List allwindows;
//   final Widget menuwindow;
//   final Widget? tocall;
//
//   const ScreenDisp({
//     Key? key,
//     required this.allwindows,
//     required this.menuwindow,
//     this.tocall,
//   }) : super(key: key);
//
//   @override
//   State<ScreenDisp> createState() => _ScreenDispState();
// }
//
// class _ScreenDispState extends State<ScreenDisp>
//     with TickerProviderStateMixin {
//   late TabController controller2;
//
//   int activetab = 0;
//   int active = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller2 = TabController(
//       length: widget.allwindows.length,
//       vsync: this,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DefaultTabController(
//           length: openScreenstitles.length,
//           initialIndex: 0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           '${companyInView}',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '${module}',
//                           style: modname,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Card(
//                       child: TabBar(
//                         indicatorColor: Colors.white,
//                         isScrollable: true,
//                         tabs: openScreenstitles
//                             .map(
//                               (title) => Padding(
//                             padding: const EdgeInsets.all(14.0),
//                             child: Text(
//                               title,
//                               style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ),
//                         )
//                             .toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: 200,
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.transparent,
//                           offset: Offset(0, 0),
//                           blurRadius: 0,
//                           spreadRadius: 0,
//                         )
//                       ],
//                     ),
//                     height: MediaQuery.of(context).size.height * 0.88,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ListView.separated(
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           var menuList = widget.allwindows[index];
//                           return InkWell(
//                             onTap: () {
//                               if (openScreenstitles.contains(menuList.title)) {
//                                 var activeIndex =
//                                 openScreenstitles.indexOf(menuList.title);
//                                 DefaultTabController.of(context)!
//                                     .animateTo(activeIndex);
//                                 controller2.animateTo(activeIndex);
//                               } else {
//                                 setState(() {
//                                   openScreenstitles.add(menuList.title);
//                                   openScreensWidgets.add(menuList.widget);
//                                   var activeIndex =
//                                   openScreenstitles.indexOf(menuList.title);
//                                   DefaultTabController.of(context)!
//                                       .animateTo(activeIndex - 1);
//                                 });
//                               }
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: activetab == index
//                                     ? Theme.of(context).primaryColor
//                                     : Colors.blueAccent.shade200,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: CrmMenuList(crmenus: menuList),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) => SizedBox(height: 10),
//                         itemCount: widget.allwindows.length,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Card(
//                       shadowColor: Colors.red,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width - 250,
//                         height: MediaQuery.of(context).size.height * 0.873,
//                         child: TabBarView(
//                           children: openScreensWidgets
//                               .map((widget) => KeepPageAlive(child: widget),).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     controller2.dispose();
//     super.dispose();
//   }
// }
