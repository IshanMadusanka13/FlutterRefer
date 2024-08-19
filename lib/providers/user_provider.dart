import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  Future<void> addUser(User user) async {
    try {
      await _userRepository.addUser(user);
      notifyListeners();
    } catch (e) {
      print('Error in UserProvider: $e');
    }
  }
}
