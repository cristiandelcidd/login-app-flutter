import 'package:flutter/material.dart';

import 'package:login_app/router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Login Task App',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
