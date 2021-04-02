import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/services/horoscope_service.dart';
import 'package:horoscope_app/src/ui/widgets/loading_widget.dart';
import 'package:horoscope_app/src/ui/widgets/no-data_widget.dart';

class MonthlyDetailView extends StatefulWidget {
  final String name;

  MonthlyDetailView({this.name});

  @override
  _MonthlyDetailViewState createState() => _MonthlyDetailViewState();
}

class _MonthlyDetailViewState extends State<MonthlyDetailView> {
  var _monthlyHoroscope = MonthlyHoroscope();

  Future<MonthlyHoroscope> _fetchMonthlyResult() async {
    return HoroscopeService.getMonthlyHoroscope(widget.name).catchError((e) {
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
      future: _fetchMonthlyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _monthlyHoroscope = data.data;
            if (_monthlyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        _monthlyHoroscope.detail,
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
