import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/utility/constants.dart';
import 'package:horoscope_app/src/utility/nav.dart';

class HoroscopeApp extends MaterialApp {
  HoroscopeApp()
      : super(
          title: 'astrom - Daily Horoscopes',
          theme: ThemeData(
            cupertinoOverrideTheme: CupertinoThemeData(
              primaryColor: kPrimaryColor,
            ),
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Colors.white,
            ),
            accentColor: Colors.white,
            primaryColor: kPrimaryColor,
          ),
          routes: AppNavigation.routes,
          // home: HomePage(),
        );

  static Future<void> initiate() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppData.initialize();
    print(AppData().getIsNew());
    // await AppData().clearData();
  }
}
