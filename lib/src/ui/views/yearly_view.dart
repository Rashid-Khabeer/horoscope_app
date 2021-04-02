import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/services/horoscope_service.dart';
import 'package:horoscope_app/src/ui/widgets/loading_widget.dart';
import 'package:horoscope_app/src/ui/widgets/no-data_widget.dart';

class YearlyDetailView extends StatefulWidget {
  final String name;

  YearlyDetailView({this.name});

  @override
  _YearlyDetailViewState createState() => _YearlyDetailViewState();
}

class _YearlyDetailViewState extends State<YearlyDetailView> {
  var _yearlyHoroscope = YearlyHoroscope();

  Future<YearlyHoroscope> _fetchYearlyResult() async {
    return HoroscopeService.getYearlyHoroscope(widget.name).catchError((e) {
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
      future: _fetchYearlyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _yearlyHoroscope = data.data;
            if (_yearlyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        _yearlyHoroscope.detail,
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
