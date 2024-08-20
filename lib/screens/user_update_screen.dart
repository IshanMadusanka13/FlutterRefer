import 'package:flutter/material.dart';
import 'package:flutter_refer/repositories/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_refer/models/user.dart';
import '../providers/user_provider.dart';

class UserUpdateScreen extends StatefulWidget {
  final String userId;

  UserUpdateScreen({required this.userId});

  @override
  _UserUpdateScreenState createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = await UserRepository().getUser(widget.userId);

    if (user != null) {
      _fNameController.text = user.fName;
      _lNameController.text = user.lName;
      _dobController.text = user.dob.toIso8601String().split('T').first;
      _usernameController.text = user.username;
      _passwordController.text = user.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _fNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => _checkNull('First Name', value),
              ),
              TextFormField(
                controller: _lNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => _checkNull('Last Name', value),
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                validator: (value) => _checkNull('Date of Birth', value),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => _checkNull('Username', value),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => _checkNull('Password', value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _checkNull(String field, String? value) {
    if (value == null || value.isEmpty) {
      return "$field cannot be empty";
    }
    return null;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: widget.userId,
        fName: _fNameController.text,
        lName: _lNameController.text,
        dob: DateTime.parse(_dobController.text),
        username: _usernameController.text,
        password: _passwordController.text,
      );

      UserRepository().updateUser(user.id,user).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Updated successfully!')));
        context.go("/");
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to Update user')));
      });
    }
  }
}
