import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String fName;
  String lName;
  DateTime dob;
  String username;
  String password;

  User({
    this.id = '',
    required this.fName,
    required this.lName,
    required this.dob,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'dob': dob.toIso8601String(),
      'username': username,
      'password': password,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      fName: data['fName'],
      lName: data['lName'],
      dob: DateTime.parse(data['dob']),
      username: data['username'],
      password: data['password'],
    );
  }
}
