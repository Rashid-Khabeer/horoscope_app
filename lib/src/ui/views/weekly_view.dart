import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/services/horoscope_service.dart';
import 'package:horoscope_app/src/ui/widgets/loading_widget.dart';
import 'package:horoscope_app/src/ui/widgets/no-data_widget.dart';

class WeeklyDetailView extends StatefulWidget {
  final String name;

  WeeklyDetailView({this.name});

  @override
  _WeeklyDetailViewState createState() => _WeeklyDetailViewState();
}

class _WeeklyDetailViewState extends State<WeeklyDetailView> {
  var _weeklyHoroscope = WeeklyHoroscope();

  Future<WeeklyHoroscope> _fetchWeeklyResult() async {
    return HoroscopeService.getWeeklyHoroscope(widget.name).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchWeeklyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _weeklyHoroscope = data.data;
            if (_weeklyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        _weeklyHoroscope.detail,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              );
            }
          } else
            return LoadingWidget();
        }
      },
    );
  }
}
