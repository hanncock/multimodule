import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3/Services/Services.dart';
import 'package:intl/intl.dart';

const defaultPadding = 16.0;

final AuthService auth = AuthService();

final ft = new DateFormat('dd-MMM-yyyy | hh:mm a ');
final f = new DateFormat('yyyy-MM-dd');
const dateFormat4 = 'yyyy-MM-dd';

clearlogs()async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.get('Userdata');
    prefs.clear();

    // Navigator.pushAndRemoveUntil(
    //     context, MaterialPageRoute(builder: (context) => LocationScreen()), (
    //     route) => false);


}


class Themes {
    final lightTheme = ThemeData.light().copyWith(
        primaryColor: Color.fromRGBO(0,87,255,1),
        // useMaterial3: true,
        cardColor: Color(0xFFFFFFFF),
        // textTheme: GoogleFonts.poppinsTextTheme(),
        textTheme: (GoogleFonts.poppinsTextTheme().copyWith()),
        iconTheme: IconThemeData(
            color: Color(0xFFFFFFFF),
        ),


    );

    final darkTheme = ThemeData.light().copyWith(
        primaryColor: Colors.black,
        cardColor: Colors.white,
        // useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        iconTheme: IconThemeData(
            color: Color(0xFFFFFFFF),
        )

    );
}

// ThemeData lightTheme(context){
//     return ThemeData(
//         iconTheme: IconThemeData(
//             color: Color(0xFFFFFFFF)
//         ),
//         // elevation: 0,
//         // actionsIconTheme: IconThemeData(color: Colors.yellow),
//         // fontFamily: GoogleFonts.inriaSans().fontFamily,
//         textTheme: GoogleFonts.latoTextTheme(
//             Theme.of(context).textTheme
//         ),
//         primaryColor: Colors.blueAccent,
//         scaffoldBackgroundColor: Colors.grey[200],
//         cardColor: Colors.grey,
//         buttonTheme: ButtonThemeData(
//             buttonColor: Colors.deepPurple,     //  <-- dark color
//             textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
//         ),
//         canvasColor: Colors.blueAccent
//     );
// }

// ThemeData darkTheme(context){
//     return ThemeData(
//         fontFamily: GoogleFonts.roboto().fontFamily,
//         iconTheme: IconThemeData(
//             color: Color(0xFFFFFFFF)
//         ),
//         // primaryColor: Colors.yellow,
//         // scaffoldBackgroundColor: Colors.black,
//         // cardColor: Colors.red,
//         buttonTheme: ButtonThemeData(
//             buttonColor: Colors.yellow,         //  <-- light color
//             textTheme: ButtonTextTheme.primary, //  <-- dark text for light background
//         ),
//         // canvasColor: Colors.blueAccent,
//
//
//     );
// }
// // const primaryColor = Color(0xFF2697FF);
// // const secondaryColor = Color(0xFF2A2D3E);
// // const secondaryColor = Color(0xB3FFFFFF);
// const secondaryColor = Color(0xFFFFFFFF);
// // const bgColor = Color(0xFF212332);
// // const bgColor = Color(0xF5F5F5); //black54
// // const bgColor = Color(0xFFE3F2FD); //black54
// const bgColor = Color(0xFFE3F2FD); //black54
//
//
//
// const primaryColor = Color(0xff2979ff);
// const primaryfontColor = Color(0xFFFFFFFF);
//
const header1 = TextStyle(
  // fontSize: 18,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.2


);
const header2 = TextStyle(
    fontWeight: FontWeight.bold,
    // fontSize: 18,
    letterSpacing: 1.5,
    color: Color(0xFFFFFFFF)

);

const modname = TextStyle(
    fontWeight: FontWeight.bold,
    // fontSize: 20,
    letterSpacing: 1.5,
    // color: Color(0xFFFFFFFF)

);
//
const header2Dash = TextStyle(
//     fontSize: 18,
    letterSpacing: 1,
    // color: Color(0xFFFFFFFF)

);

const boldfont = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    letterSpacing: 1
);

const menutitle = TextStyle(
    // fontSize: 16,
    letterSpacing: 1,
    color: Color(0xFFFFFFFF)

);

const normal = TextStyle(
    // fontSize: 14,
    letterSpacing: 1,
    // color: Color(0xFFFFFFFF)
);
