import 'package:flutter/material.dart';
import 'package:horoscope_app/src/utility/constants.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 45,
        height: 45,
        child: CircularProgressIndicator(
          backgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
