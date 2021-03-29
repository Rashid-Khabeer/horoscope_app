import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/utility/constants.dart';

class NoDataWidget extends StatelessWidget {
  final String message;

  NoDataWidget({this.message = 'Failed to load post'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            size: 100,
            color: kPrimaryColor,
          ),
          SizedBox(height: 10.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
