import 'package:flutter/material.dart';
import 'package:horoscope_app/src/ui/widgets/loading_widget.dart';

openLoadingDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.all(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 35,
            height: 35,
            child: LoadingWidget(),
          ),
          SizedBox(height: 15),
          Text(text + "...")
        ],
      ),
    ),
  );
}
