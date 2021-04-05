import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentLogs {
  String personEmail;
  String amount;
  Timestamp timestamp;
  bool status;

  PaymentLogs({
    this.timestamp,
    this.status,
    this.amount,
    this.personEmail,
  });

  PaymentLogs.fromJson(Map<String, dynamic> json) {
    personEmail = json['personEmail'];
    amount = json['amount'];
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'personEmail': personEmail,
      'amount': amount,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
