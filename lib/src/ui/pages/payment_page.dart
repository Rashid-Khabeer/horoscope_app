import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/data/models/payment-logs_model.dart';
import 'package:horoscope_app/src/services/payment-firestore_service.dart';
import 'package:horoscope_app/src/services/payment_service.dart';
import 'package:horoscope_app/src/services/person_service.dart';
import 'package:horoscope_app/src/ui/modals/loading_dialog.dart';
import 'package:horoscope_app/src/utility/assets.dart';
import 'package:horoscope_app/src/utility/constants.dart';

class PaymentPage extends StatefulWidget {
  final Function callBack;

  PaymentPage({@required this.callBack});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Purchase'),
      ),
      body: Center(
        child: AppData().getHasPayed()
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.checkmark_seal_fill,
                    color: kPrimaryColor,
                    size: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'You has subscription',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    AppData().getEmail(),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.appLogo,
                      width: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        'Pay to get ads free version',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _performPay,
                        child: Text(
                          'Pay'.toUpperCase(),
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

  _performPay() async {
    if (!AppData().getSignIn()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please sign in first'),
        ),
      );
      return;
    }
    openLoadingDialog(context, 'Processing');
    var response = await StripeService.pay(
      amount: '3',
      currency: 'USD',
    );
    if (response.success) {
      AppData().setHasPayed(true);
      final result = await PersonService().fetchOnePerson(AppData().getEmail());
      result.hasPaid = true;
      await PersonService().updatePerson(result);
    }
    await PaymentFirestoreService().addPaymentLog(PaymentLogs(
      amount: '',
      personEmail: AppData().getEmail(),
      status: response.success,
      timestamp: Timestamp.now(),
    ));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              response.success
                  ? CupertinoIcons.info
                  : CupertinoIcons.exclamationmark_square,
            ),
            SizedBox(width: 5.0),
            Expanded(child: Text(response.message)),
          ],
        ),
      ),
    );
    widget.callBack();
    setState(() {});
  }
}
