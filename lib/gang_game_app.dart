import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class GangGameApp extends StatelessWidget {
  const GangGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gang Strategy Game',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
