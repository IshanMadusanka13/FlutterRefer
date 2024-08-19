import 'package:flutter/material.dart';
import 'package:flutter_refer/screens/home_screen.dart';
import 'package:flutter_refer/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    ],
  );
}
