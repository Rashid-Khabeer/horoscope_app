import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/utility/assets.dart';
import 'package:horoscope_app/src/utility/constants.dart';
import 'package:horoscope_app/src/utility/nav.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Zodiac _selectedZodiac;
  var _dateOfBirth = DateTime.now();

  _selectNewZodiac(DateTime dateTime) {
    final _tempDateTime = DateTime(2000, dateTime.month, dateTime.day);
    for (final _zodiac in Zodiac.zodiacList) {
      if (_tempDateTime.isAfter(_zodiac.firstDate) &&
          _tempDateTime.isBefore(_zodiac.lastDate)) {
        _dateOfBirth = dateTime;
        _selectedZodiac = _zodiac;
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _selectNewZodiac(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.appLogo,
                // _selectedZodiac.imageName,
                width: 150,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 40,
                  ),
                  child: Text(
                    'Select your date of birth',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                child: DatePickerWidget(
                  onChange: (selectedDate, _) => _selectNewZodiac(selectedDate),
                  pickerTheme: DateTimePickerTheme(
                    itemTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'della',
                    ),
                    dividerColor: kPrimaryColor,
                    backgroundColor: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () async {
                    await AppData().setIsNew(true);
                    await AppData().setDateOfBirth(_dateOfBirth.toString());
                    await AppData().setStarName(_selectedZodiac.name);
                    Navigator.of(context).pop();
                    AppNavigation.toPage(context, AppPage.detailPage);
                  },
                  child: Text(
                    'Synchronized'.toUpperCase(),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
