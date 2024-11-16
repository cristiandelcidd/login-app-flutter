import 'package:go_router/go_router.dart';

import 'package:login_app/modules/auth/pages/login_page.dart';
import 'package:login_app/modules/auth/pages/register_page.dart';
import 'package:login_app/modules/home/pages/home_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
