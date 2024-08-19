import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class RegisterScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final user = User(
                      fName: _fNameController.text,
                      lName: _lNameController.text,
                      dob: DateTime.parse(_dobController.text),
                      username: _usernameController.text,
                      password: _passwordController.text,
                    );

                    Provider.of<UserProvider>(context, listen: false).addUser(user).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User registered successfully!')));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to register user')));
                    });
                  }
                },
                child: const Text('Register'),
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
        fName: _fNameController.text,
        lName: _lNameController.text,
        dob: DateTime.parse(_dobController.text),
        username: _usernameController.text,
        password: _passwordController.text,
      );

      Provider.of<UserProvider>(context, listen: false).addUser(user).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered successfully!')));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to register user')));
      });
    }
  }
}
