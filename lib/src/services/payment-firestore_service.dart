import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horoscope_app/src/data/models/payment-logs_model.dart';

class PaymentFirestoreService {
  static const _collectionName = 'Payment';
  var _db = FirebaseFirestore.instance.collection(_collectionName);

  Future<PaymentLogs> addPaymentLog(PaymentLogs logs) async {
    final document = await _db.add(logs.toJson());
    return logs;
  }
}
