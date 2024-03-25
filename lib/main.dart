import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Constants/Theme.dart';
import 'package:web3/Screens/Login/login.dart';
import 'Screens/Wrapper.dart';
import 'allHomes/all_homes.dart';

void main() {
  runApp(MyApp());
}

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
          themeMode: ThemeMode.system,
          theme: Themes().lightTheme,
          darkTheme: Themes().darkTheme,

          // theme: lightTheme(context),
          // darkTheme: darkTheme(context),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: widtest(),
          home: Wrapper(sessionStateStream: sessionStateStream,),
          // home: AllHomes(sessionStateStream: sessionStateStream,),
          // home: Login(sessionStateStream: sessionStateStream,),
          // home: CRMDash(),
          // home: Companies(),
          // home: MultiProvider(
          //   providers: [
          //     ChangeNotifierProvider(create: (context)=>MenuController(),)
          //     // ChangeNotifierProvider(create: (context) => MenuController())
          //   ],
          //   child: homeScreen(),
          // ),
        )
    );
    // return GetMaterialApp(
    //   themeMode: ThemeMode.system,
    //   theme: Themes().lightTheme,
    //   darkTheme: Themes().darkTheme,
    //   // theme: lightTheme(context),
    //   // darkTheme: darkTheme(context),
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   // home: homeScreen(),
    //   // home: AllHomes(),
    //   home: AllHomes(),
    //   // home: Login(),
    //   // home: CRMDash(),
    //   // home: Companies(),
    //   // home: MultiProvider(
    //   //   providers: [
    //   //     ChangeNotifierProvider(create: (context)=>MenuController(),)
    //   //     // ChangeNotifierProvider(create: (context) => MenuController())
    //   //   ],
    //   //   child: homeScreen(),
    //   // ),
    // );
  }
}
