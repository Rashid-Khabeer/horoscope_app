import 'dart:convert';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/utility/constants.dart';
import 'package:http/http.dart' as http;

class HoroscopeService {
  static Future<DayHoroscope> getDayHoroscope(String zodiacSign) async {
    final response =
        await http.post(Uri.parse('$kSecondaryUrl/?sign=$zodiacSign&day=today'));
    if (response.statusCode == 200) {
      return DayHoroscope.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<DailyHoroscope> getDailyHoroscope(String zodiacSign) async {
    final response = await http.get(Uri.parse('$kMainUrl/today/$zodiacSign'));
    if (response.statusCode == 200) {
      return DailyHoroscope.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<WeeklyHoroscope> getWeeklyHoroscope(String zodiacSign) async {
    final response = await http.get(Uri.parse('$kMainUrl/week/$zodiacSign'));
    if (response.statusCode == 200) {
      return WeeklyHoroscope.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<MonthlyHoroscope> getMonthlyHoroscope(String zodiacSign) async {
    final response = await http.get(Uri.parse('$kMainUrl/month/$zodiacSign'));
    if (response.statusCode == 200) {
      return MonthlyHoroscope.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<YearlyHoroscope> getYearlyHoroscope(String zodiacSign) async {
    final response = await http.get(Uri.parse('$kMainUrl/year/$zodiacSign'));
    if (response.statusCode == 200) {
      return YearlyHoroscope.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
