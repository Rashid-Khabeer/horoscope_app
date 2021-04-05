import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/ui/pages/detail_page.dart';
import 'package:horoscope_app/src/ui/pages/menu_page.dart';
import 'package:horoscope_app/src/ui/pages/welcome_page.dart';

class AppPage {
  final String _name;

  const AppPage._(this._name);

  static const mainPage = AppPage._('/');
  static const detailPage = AppPage._('/detailPage');
  static const menuPage = AppPage._('/menuPage');
}

abstract class AppNavigation {
  static Future<dynamic> to(BuildContext context, Widget page) async {
    return await Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => page,
    ));
  }

  static Future<dynamic> toPage(BuildContext context, AppPage page) async {
    return await Navigator.of(context).pushNamed(page._name);
  }

  static navigateRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (BuildContext con) => page),
      (route) => false,
    );
  }

  static final routes = <String, WidgetBuilder>{
    AppPage.mainPage._name: (context) =>
        AppData().getIsNew() ? DetailPage() : WelcomePage(),
    AppPage.detailPage._name: (context) => DetailPage(),
    AppPage.menuPage._name: (context) => MenuPage(),
  };
}
