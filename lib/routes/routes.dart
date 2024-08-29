import 'package:flutter/material.dart';
import 'package:flutter_refer/screens/home_screen.dart';
import 'package:flutter_refer/screens/register_screen.dart';
import 'package:flutter_refer/screens/splash_screen.dart';
import 'package:flutter_refer/screens/user_list_screen.dart';
import 'package:flutter_refer/screens/user_update_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
      GoRoute(path: '/users', builder: (context, state) => UserListScreen()),
      GoRoute(
        path: '/update',
        builder: (context, state) {
          final userId = state.extra as String;
          return UserUpdateScreen(userId: userId ?? 'defaultUserId');
        },
      ),
    ],
  );
}
