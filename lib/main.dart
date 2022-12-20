import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/utils/constants.dart';
import 'package:metrics_app/utils/widget_functions.dart';
import 'utils/constants.dart';
import 'dart:ui';

import 'Controllers/Notifications.dart';
import 'Screens/HomePages/views/Home.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await FirebaseMessaging.instance.getInitialMessage();
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Episode 1',
      theme: ThemeData(
          primaryColor: COLOR_WHITE,
          accentColor: COLOR_DARK_BLUE,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          fontFamily: "Maersk"),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.assessment_rounded,
          color: Colors.white,
        ),
        label: 'Visible'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.assessment_rounded,
          color: Colors.white,
        ),
        label: 'B2C'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.assessment_rounded,
          color: Colors.white,
        ),
        label: 'Hub'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.assessment_rounded,
          color: Colors.white,
        ),
        label: 'Totals'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex){
            setState(() {
              _currentIndex = newIndex;
            });
          },
          children: [

            B2CPage(),

          ],
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   items: _bottomNavigationBarItems,
        //   iconSize: 30,
        //   backgroundColor: Colors.black,
        //   type: BottomNavigationBarType.fixed,
        //   unselectedItemColor: Colors.white54,
        //   selectedItemColor: Colors.white,
        //   onTap: (index) {
        //     _pageController.animateToPage(index, duration: const Duration(microseconds: 500), curve: Curves.ease);
        ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
