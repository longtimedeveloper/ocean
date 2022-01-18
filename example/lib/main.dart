import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import './src/src.dart';

void main() {
  AppBootStrapper().setup();
  AppDialogs().setup();
  AppSnackBars().setup();
  AppOceanEntities().setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigatorService>().navigatorKey,
      scaffoldMessengerKey: locator<SnackBarKeyService>().snackBarKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
