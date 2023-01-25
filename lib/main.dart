import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:metrics_app/Screens/HomePages/bindings/home_bindings.dart';
import 'package:metrics_app/Screens/root/bindings/root_bindings.dart';
import 'package:metrics_app/utils/constants.dart';
import 'Screens/FiltersPage/Filter.dart';
import 'Screens/HomePages/views/Home.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return GetMaterialApp(
      title: 'Metrics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: COLOR_WHITE,
          accentColor: COLOR_DARK_BLUE,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          fontFamily: "Maersk"),
      initialBinding: RootBindings(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage(), title: 'Monthly Averages', binding: HomeBinding()),
        GetPage(name: '/filters', page: () => FilterDropDown(), title: 'Filters'),
      ],
    );
  }
}
