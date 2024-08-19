import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('assets/Logo.png', width: 100.0, height: 100.0),
            const SizedBox(height: 20.0),

            ElevatedButton(onPressed: () => context.go('/register'), child: const Text("Register")),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: ()=> context.go('/users'), child: const Text("All Users")),

          ],
        ),
      ),
    );
  }
}
