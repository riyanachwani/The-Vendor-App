import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter/cupertino.dart';

const String notificationChannelId = 'channelid';

class NotificationService {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    // Configure notification details
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      notificationChannelId,
      'Inventory Low',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformDetails,
    );
  }
}
