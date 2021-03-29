import 'package:flutter/material.dart';
import 'package:horoscope_app/src/app.dart';

void main() async {
  await HoroscopeApp.initiate();
  runApp(HoroscopeApp());
}
