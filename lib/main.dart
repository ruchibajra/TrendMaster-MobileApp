import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendmasterass2/pages/login_page.dart';
import 'package:trendmasterass2/pages/search.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Theme Style
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.teal,
            titleTextStyle: TextStyle(fontSize: 22, color: Colors.white,)),
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
        //Route
        routes: <String, WidgetBuilder>{
          "/": (context) => LoginPage(),
          // "/": (context) => SearchPage(),

        }
    );
  }
}


