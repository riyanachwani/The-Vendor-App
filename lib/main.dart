import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_vendor/pages/landing_page.dart';
import 'package:flutter_vendor/pages/widget/themes.dart';
import 'package:flutter_vendor/utils/firestore_service.dart';
import 'package:flutter_vendor/utils/notifications.dart';
import 'pages/login1.dart';
import 'pages/login2.dart';
import 'pages/login3.dart';
import "utils/routes.dart";
import 'pages/home_page1.dart';
import 'pages/home_page2.dart';
import 'pages/home_page3.dart';
import 'pages/forgot_password.dart';
import 'package:permission_handler/permission_handler.dart';

//Email = vendor1@gmail.com and Password = vendor1
//Email = vendor2@gmail.com and Password = vendor2
//Email = vendor3@gmail.com and Password = vendor3

final FirestoreService _firestoreService = FirestoreService();
final NotificationService n = NotificationService();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((_) {
    print("Firebase initialized successfully!");
  }).catchError((error) {
    print("Error initializing Firebase: $error");
  });
  await requestNotificationPermissions();
  await _initializeNotifications();
  await checkInventoryAndShowNotification(); // Check on app launch
  // Schedule periodic checks (e.g., every 5 minutes) using Timer
  Timer.periodic(const Duration(minutes: 5),
      (timer) => checkInventoryAndShowNotification());
  runApp(const MyApp());
}

Future<void> requestNotificationPermissions() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    // Notification permissions granted
  } else if (status.isDenied) {
    // Notification permissions denied
  } else if (status.isPermanentlyDenied) {
    // Notification permissions permanently denied, open app settings
    await openAppSettings();
  }
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Use your app icon
  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> checkInventoryAndShowNotification() async {
  DocumentSnapshot snapshot = await _firestoreService.getInventoryData();
  if (snapshot.exists && _firestoreService.hasLowInventory(snapshot)) {
    await NotificationService.showNotification(
      title: 'Low Inventory Alert!',
      body:
          'Inventory levels are running low! Please take action to replenish.',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner:
          false, //to remove the debug that is shown on app
      initialRoute: MyRoutes.landingRoute,
      routes: {
        '/': (context) => LandingPage(),
        MyRoutes.landingRoute: (context) => LandingPage(),
        MyRoutes.homeRoute1: (context) => const HomePage1(),
        MyRoutes.homeRoute2: (context) => const HomePage2(),
        MyRoutes.homeRoute3: (context) => const HomePage3(),
        MyRoutes.loginRoute1: (context) => const LoginPage1(),
        MyRoutes.loginRoute2: (context) => const LoginPage2(),
        MyRoutes.loginRoute3: (context) => const LoginPage3(),
        MyRoutes.forgotPasswordRoute: (context) => const ForgotPassword(),
      },
    );
  }
}
