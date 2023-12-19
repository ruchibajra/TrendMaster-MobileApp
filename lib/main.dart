import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendmasterass2/pages/registration.dart';
import 'package:trendmasterass2/pages/signin_page.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          "/": (context) => InfluencerRegistrationScreen(),
          // "/": (context) => CreatorsPage(),
          // "/": (context) => CompanyHomePage(),
          // "/": (context) => InfluencerProfile(),
          // "/": (context) => InfluencerHomePage(),
          // "/": (context) => Budget(),
          // "/": (context) => LoginPage(),
          // "/": (context) => AddDetailsPage(),
          // "/": (context) => CompanyLocationPage(),
          // "/": (context) => CompanySuccessPage(),
          // "/": (context) => InfluencerHomePage(),
          // "/": (context) => CampaignDetailPage(),
        }
    );
  }
}


