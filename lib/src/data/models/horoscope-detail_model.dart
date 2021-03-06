import 'package:horoscope_app/src/utility/assets.dart';

class DayHoroscope {
  String dateRange;
  String currentDate;
  String description;
  String compatibility;
  String mood;
  String color;
  String luckyNumber;
  String luckyTime;

  DayHoroscope({
    this.color,
    this.description,
    this.compatibility,
    this.currentDate,
    this.dateRange,
    this.luckyNumber,
    this.luckyTime,
    this.mood,
  });

  DayHoroscope.fromJson(Map<String, dynamic> json) {
    dateRange = json['date_range'];
    currentDate = json['current_date'];
    description = json['description'];
    compatibility = json['compatibility'];
    mood = json['mood'];
    color = json['color'];
    luckyNumber = json['lucky_number'];
    luckyTime = json['lucky_time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date_range': dateRange,
      'current_date': currentDate,
      'description': description,
      'compatibility': compatibility,
      'mood': mood,
      'color': color,
      'lucky_number': luckyNumber,
      'lucky_time': luckyTime,
    };
  }
}

class DailyHoroscope {
  String date;
  String detail;
  String sunSign;

  DailyHoroscope({this.detail, this.date, this.sunSign});

  DailyHoroscope.fromJson(Map<String, dynamic> json) {
    date = json['date'];
      detail = json['horoscope'];
    sunSign = json['sunsign'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': this.date,
      'horoscope': this.detail,
      'sunsign': this.sunSign,
    };
  }
}

class WeeklyHoroscope {
  String week;
  String detail;
  String sunSign;

  WeeklyHoroscope({this.detail, this.week, this.sunSign});

  WeeklyHoroscope.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    detail = json['horoscope'];
    sunSign = json['sunsign'];
  }

  Map<String, dynamic> toJson() {
    return {
      'week': this.week,
      'horoscope': this.detail,
      'sunsign': this.sunSign,
    };
  }
}

class MonthlyHoroscope {
  String month;
  String detail;
  String sunSign;

  MonthlyHoroscope({this.detail, this.month, this.sunSign});

  MonthlyHoroscope.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    detail = json['horoscope'];
    sunSign = json['sunsign'];
  }

  Map<String, dynamic> toJson() {
    return {
      'month': this.month,
      'horoscope': this.detail,
      'sunsign': this.sunSign,
    };
  }
}

class YearlyHoroscope {
  String year;
  String detail;
  String sunSign;

  YearlyHoroscope({this.detail, this.year, this.sunSign});

  YearlyHoroscope.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    detail = json['horoscope'];
    sunSign = json['sunsign'];
  }

  Map<String, dynamic> toJson() {
    return {
      'year': this.year,
      'horoscope': this.detail,
      'sunsign': this.sunSign,
    };
  }
}

class Zodiac {
  final String name;
  final String dateRange;
  final String imageName;
  final DateTime firstDate;
  final DateTime lastDate;
  final String sign;
  final String planet;
  final String element;

  Zodiac({
    this.dateRange,
    this.name,
    this.imageName,
    this.lastDate,
    this.firstDate,
    this.element,
    this.sign,
    this.planet,
  });

  static final zodiacList = [
    Zodiac(
      dateRange: 'January 20-February 18',
      name: 'aquarius',
      imageName: AppAssets.aquarius,
      firstDate: DateTime(2000, 1, 20),
      lastDate: DateTime(2000, 2, 18),
      element: 'Air',
      planet: 'Uranus, Saturn',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'February 19-March 20',
      name: 'pisces',
      imageName: AppAssets.pisces,
      firstDate: DateTime(2000, 2, 19),
      lastDate: DateTime(2000, 3, 20),
      element: 'Water',
      planet: 'Neptune, Jupiter',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'March 21 - April 19',
      name: 'aries',
      imageName: AppAssets.aries,
      firstDate: DateTime(2000, 3, 21),
      lastDate: DateTime(2000, 4, 19),
      element: 'Fire',
      planet: 'Mars',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'April 20 - May 20',
      name: 'taurus',
      imageName: AppAssets.taurus,
      firstDate: DateTime(2000, 4, 20),
      lastDate: DateTime(2000, 5, 20),
      element: 'Earth',
      planet: 'Venus',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'May 21 - June 20',
      name: 'gemini',
      imageName: AppAssets.gemini,
      firstDate: DateTime(2000, 5, 21),
      lastDate: DateTime(2000, 6, 20),
      element: 'Air',
      planet: 'Mercury',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'June 21 - July 22',
      name: 'cancer',
      imageName: AppAssets.cancer,
      firstDate: DateTime(2000, 6, 21),
      lastDate: DateTime(2000, 7, 22),
      element: 'Water',
      planet: 'Moon',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'July 23 - August 22',
      name: 'leo',
      imageName: AppAssets.leo,
      firstDate: DateTime(2000, 7, 23),
      lastDate: DateTime(2000, 8, 22),
      element: 'Fire',
      planet: 'Sun',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'August 23 - September 22',
      name: 'virgo',
      imageName: AppAssets.virgo,
      firstDate: DateTime(2000, 8, 23),
      lastDate: DateTime(2000, 9, 22),
      element: 'Earth',
      planet: 'Mercury',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'September 23 - October 22',
      name: 'libra',
      imageName: AppAssets.libra,
      firstDate: DateTime(2000, 9, 23),
      lastDate: DateTime(2000, 10, 22),
      element: 'Air',
      planet: 'Venus',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'October 23 - November 21',
      name: 'scorpio',
      imageName: AppAssets.scorpio,
      firstDate: DateTime(2000, 10, 23),
      lastDate: DateTime(2000, 11, 21),
      element: 'Water',
      planet: 'Pluto, Mars',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'November 22 - December 21',
      name: 'sagittarius',
      imageName: AppAssets.sagittarius,
      firstDate: DateTime(2000, 11, 22),
      lastDate: DateTime(2000, 12, 21),
      element: 'Fire',
      planet: 'Jupiter',
      sign: 'Sun',
    ),
    Zodiac(
      dateRange: 'December 22 - January 19',
      name: 'capricorn',
      imageName: AppAssets.capricorn,
      firstDate: DateTime(2000, 12, 22),
      lastDate: DateTime(2000, 1, 19),
      element: 'Earth',
      planet: 'Saturn',
      sign: 'Sun',
    ),
  ];
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${this.substring(1)}';
}
