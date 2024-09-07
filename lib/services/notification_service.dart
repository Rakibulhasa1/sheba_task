import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/todo.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       );
  }

  Future<void> scheduleNotification(Todo todo) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      todo.id.hashCode,
      'Reminder: ${todo.title}',
      'The task is due now',
      tz.TZDateTime.from(todo.dueDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'todo_channel',
          'TODO Notifications',
          importance: Importance.high,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: todo.id,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      Navigator.of(GlobalKey<NavigatorState>().currentContext!).pushNamed(
        '/todoDetails',
        arguments: payload,
      );
    }
  }
}
