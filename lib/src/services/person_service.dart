import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:horoscope_app/src/data/models/person_model.dart';

class PersonService {
  static const _collectionName = 'Persons';
  var _db = FirebaseFirestore.instance.collection(_collectionName);

  Person _parsePerson(DocumentSnapshot documentSnapshot) =>
      Person.fromJson(documentSnapshot.data())..id = documentSnapshot.id;

  Future<Person> addPerson({@required Person person}) async {
    final document = await _db.add(person.toJson());
    person.id = document.id;
    return person;
  }

  Future<Person> checkLogin(String email, String password) async {
    List<DocumentSnapshot> doc;
    await _db
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((value) => doc = value.docs);
    if (doc.isNotEmpty)
      return _parsePerson(doc.first);
    else
      return null;
  }

  Future<Person> fetchOnePerson(String email) async {
    List<DocumentSnapshot> docs;
    await FirebaseFirestore.instance
        .collection(_collectionName)
        .where('email', isEqualTo: email)
        .get()
        .then((value) => docs = value.docs);
    return docs.isNotEmpty ? _parsePerson(docs.first) : null;
  }

  Stream<Person> fetchOneStreamPerson(String id) =>
      _db.doc(id).snapshots().map((snapshot) => _parsePerson(snapshot));

  updatePerson(Person person) async {
    return await FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(person.id)
        .set(person.toJson());
  }
}
