import 'package:flutter/material.dart';

import 'dart:async';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/Login/login.dart';
import 'Screens/Wrapper.dart';
import 'all_homes.dart';

void main() {
  runApp(MyApp());
}
//
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             textTheme: Theme.of(context).textTheme.apply(
//               fontSizeFactor: .75,
//               fontSizeDelta: 1.0,
//             ),
//           ),
//           child: child!,
//         );
//       },
//       home: Wrapper(), // Replace this with your home screen widget
//       // other MaterialApp properties...
//     );
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  final sessionStateStream = StreamController<SessionState>();

  clearlogs()async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.get('Userdata');
    prefs.clear();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 10),
      invalidateSessionForUserInactivity: const Duration(minutes: 10),
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      // sessionStateStream.add(SessionState.stopListening);
      sessionStateStream.add(SessionState.startListening);

      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        print('logging you out');
        clearlogs();
        // popup(context);
        // Builder(builder: (BuildContext context) { return popup(context); },);
        print('logged out');
        // handle user  inactive timeout

        Navigator.push(context, MaterialPageRoute(
          builder: (_) => Login(
            sessionStateStream: sessionStateStream,
            // loggedOutReason: "Logged out because of user inactivity"
          ),
        ));
        Navigator.push(context, MaterialPageRoute(
            builder: (_) =>
                Wrapper(sessionStateStream: sessionStateStream,)));


      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        print('locking');
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => Login(sessionStateStream: sessionStateStream,
            // loggedOutReason: "Logged out because app lost focus"
          ),
        ));
      }
    });


    return SessionTimeoutManager(
        userActivityDebounceDuration: const Duration(minutes: 10),
        sessionConfig: sessionConfig,
        sessionStateStream: sessionStateStream.stream,
        child: GetMaterialApp(
          builder: (context, child){
            return Theme(
                data: Theme.of(context).copyWith(
                  textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: .9,
                    fontSizeDelta: 0.1,
                    // fontFamily: GoogleFonts.openSans().fontFamily!
                    // fontFamily: GoogleFonts.raleway().fontFamily!
                      // poppinsTextTheme()
                    fontFamily: GoogleFonts.poppins().fontFamily
                  ),
                ),
                child: child!
            );
          },
          themeMode: ThemeMode.system,
          theme: Themes().lightTheme,
          darkTheme: Themes().darkTheme,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: widtest(),
          home: Wrapper(sessionStateStream: sessionStateStream,),
        )
    );

  }
}
//
// /*
//
//
//
//  */
//
//
// // import 'package:flutter/material.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: HomeScreen(),
// //     );
// //   }
// // }
//
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
// //   TabController? _tabController;
// //   List<Widget> _tabs = [Tab(text: 'Tab 1')];
// //   List<Widget> _tabViews = [Center(child: Text('Content 1'))];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: _tabs.length, vsync: this);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         bottom: TabBar(
// //           controller: _tabController,
// //           tabs: _tabs,
// //         ),
// //         title: Text('Tabs Example'),
// //       ),
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: _tabViews,
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           // Add a new tab and switch to it
// //           setState(() {
// //             _tabs.add(Tab(text: 'New Tab'));
// //             _tabViews.add(Center(child: Text('New Content')));
// //             _tabController = TabController(
// //               length: _tabs.length,
// //               vsync: this,
// //               initialIndex: _tabs.length - 1,
// //             );
// //           });
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _tabController?.dispose();
// //     super.dispose();
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: MyHomePage(),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //   int _numberOfTabs = 3; // Initial number of tabs
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: _numberOfTabs, vsync: this);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _tabController.dispose();
// //     super.dispose();
// //   }
// //
// //   // Function to add a new tab and switch to it
// //   void _addAndSwitchToTab(int tabIndex) {
// //     setState(() {
// //       _numberOfTabs++;
// //       _tabController.animateTo(tabIndex);
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Tabs Example'),
// //         bottom: TabBar(
// //           controller: _tabController,
// //           tabs: List.generate(_numberOfTabs, (index) {
// //             if (index == _numberOfTabs - 1) {
// //               return Tab(
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text('Tab ${index + 1}'),
// //                     IconButton(
// //                       icon: Icon(Icons.add),
// //                       onPressed: () => _addAndSwitchToTab(index + 1), // Add and switch to the new tab
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             } else {
// //               return Tab(text: 'Tab ${index + 1}');
// //             }
// //           }),
// //         ),
// //       ),
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: List.generate(
// //           _numberOfTabs,
// //               (index) {
// //             if (index == _numberOfTabs - 1) {
// //               return Center(
// //                 child: ElevatedButton(
// //                   onPressed: () => _addAndSwitchToTab(index), // Add and switch to the new tab
// //                   child: Text('Add Tab ${index + 2} and Switch'),
// //                 ),
// //               );
// //             } else {
// //               return Center(child: Text('Content for Tab ${index + 1}'));
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// /*working
// //
// // import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _numberOfTabs = 3; // Initial number of tabs
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _numberOfTabs, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   // Function to add a new tab and switch to it
//   void _addAndSwitchToTab() {
//     setState(() {
//       _numberOfTabs++;
//       _tabController.dispose(); // Dispose of the previous TabController
//       _tabController = TabController(length: _numberOfTabs, vsync: this); // Create a new TabController with updated length
//       _tabController.animateTo(_numberOfTabs - 1); // Switch to the newly added tab
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tabs Example'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: List.generate(_numberOfTabs, (index) {
//             return Tab(text: 'Tab ${index + 1}');
//           }),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: List.generate(
//           _numberOfTabs,
//               (index) {
//             if (index == _numberOfTabs - 1) {
//               return Center(
//                 child: ElevatedButton(
//                   onPressed: _addAndSwitchToTab, // Add a new tab and switch to it
//                   child: Text('Add Tab ${index + 2} and Switch'),
//                 ),
//               );
//             } else {
//               return Center(child: Text('Content for Tab ${index + 1}'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// } //woeking
// */
//



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List tabss = ['1','2','3'];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabss.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _tabController.index = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tab Demo'),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: List.generate(tabss.length, (index) => Container(
//             child: Center(
//                 child: Row(
//                   children: [
//                     ElevatedButton(onPressed: (){
//                       // if(tabss.contains(tabss[index])){
//                       //   print('moving');
//                       //   _tabController.animateTo(index);
//                       //   setState(() {
//                       //
//                       //   });
//                       // }else{
//                         print('adding');
//
//                       // }
//                       setState(() {
//                         tabss.add(tabss.length + 1);
//                         _tabController.animateTo(3);
//                       });
//                       // tabss.add(tabss.length + 1);
//                       // setState(() {
//                       //
//                       // });
//
//                     }, child: Text('Add new')),
//                     Text('${tabss[index]}'),
//                   ],
//                 ))))
//       ),
//       bottomNavigationBar: TabBar(
//         controller: _tabController,
//         onTap: _onTabTapped,
//         tabs: List.generate(tabss.length, (index) => Text('${tabss[index]}'))
//       ),
//     );
//   }
// }
