import 'dart:io';

import 'package:cab_rider/data_provider/app_data.dart';
import 'package:cab_rider/screens/login_page.dart';
import 'package:cab_rider/screens/main_page.dart';
import 'package:cab_rider/screens/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            googleAppID: '1:194165936582:ios:ffade47a8dba433c9062c7',
            gcmSenderID: '194165936582',
            databaseURL: 'https://gotaxi-b26f6-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            googleAppID: '1:194165936582:android:4e2fd5dbd5c1947c9062c7',
            apiKey: 'AIzaSyBaIAVDQIxwkbGyaOVUC1-SzE8s1Vd-F_w',
            databaseURL: 'https://gotaxi-b26f6-default-rtdb.firebaseio.com',
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AppData(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MainPage.id,
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),
        },
      ),
    );
  }
}
