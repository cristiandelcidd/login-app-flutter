import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:login_app/modules/pages/login_page.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    // GoRoute(
    //   path: '/register',
    //   builder: (context, state) => const RegisterScreen(),
    // ),
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) {
    //     final email = state.extra as String? ?? 'Usuario';
    //     return HomeScreen(email: email);
    //   },
    // ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Login Task App',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
