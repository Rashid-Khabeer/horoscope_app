import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/services/horoscope_service.dart';
import 'package:horoscope_app/src/ui/widgets/loading_widget.dart';
import 'package:horoscope_app/src/ui/widgets/no-data_widget.dart';

class DailyDetailView extends StatefulWidget {
  final String name;

  DailyDetailView({this.name});

  @override
  _DailyDetailViewState createState() => _DailyDetailViewState();
}

class _DailyDetailViewState extends State<DailyDetailView> {
  var _dailyHoroscope = DailyHoroscope();

  Future<DailyHoroscope> _fetchDailyResult() async {
    return HoroscopeService.getDailyHoroscope(widget.name).catchError((e) {
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
      future: _fetchDailyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _dailyHoroscope = data.data;
            if (_dailyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  // padding:
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _dailyHoroscope.detail,
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
