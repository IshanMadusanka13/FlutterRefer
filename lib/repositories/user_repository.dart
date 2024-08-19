import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserRepository {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) async {
    try {
      await _usersCollection.add(user.toMap());
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }
}
