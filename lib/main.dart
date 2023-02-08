import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'components/constants.dart';
import 'features/auth/splash/presentation/splash_screen.dart';
import 'features/planning/case_planning/presentation/case_planning_screen.dart';
import 'features/planning/case_planning/presentation/provider/cell_provider.dart';
import 'features/planning/first_planning/presentation/first_planning_screen.dart';
import 'features/planning/first_planning/presentation/provider/first_planning_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FirstPlanning>(
          create: (context) => FirstPlanning()),
      ChangeNotifierProvider<CellProvider>(create: (_) => CellProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'), // English
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF00A2FF),
      )),
      home: const SplashScreen(),
      // home: const FirstPlanningScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
