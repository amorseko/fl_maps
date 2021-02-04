import 'dart:convert';

import 'package:fl_maps/src/ui/main/list_notif.dart';
import 'package:fl_maps/src/utility/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

//import 'notification_navigate.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//class LocalNotification {
//  static Future<void> showNotification(dynamic payload) async {
//    // Parsing data notifikasi
//    print(payload);
//    final dynamic data = jsonDecode(payload['notification']['title']);
//    print(data);
//    final dynamic notification = jsonDecode(payload['notification']);
//  print(notification);
//    // Parsing ID Notifikasi
//    final int idNotification = notification['id'] != null ? int.parse(notification['id']) : 1;
//
//
//    // Daftar jenis notifikasi dari aplikasi.
//    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'BBD', 'Notification', 'All Notification is Here',
//        importance: Importance.max,
//        priority: Priority.high,
//        ticker: 'ticker');
//    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//    // Menampilkan Notifikasi
//    await flutterLocalNotificationsPlugin.show(
//        idNotification, notification['title'], notification['body'], platformChannelSpecifics,
//        payload: notification['type']);
//  }
//
//  Future<void> notificationHandler(GlobalKey<NavigatorState> navigatorKey, BuildContext context) async {
//    // Pengaturan Notifikasi
//    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('logo_bbd_sm');
//    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
//
//    // Handling notifikasi yang di tap oleh pengguna
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: (String payload) async {
//      print("data payload : " + payload);
//          if (payload != null) {
//            routeToWidget(context,ListNotifPage()).then((value) {
//              setPotrait();
//            });
////            NavigatorNavigate().go(navigatorKey, payload);
//          }
//        });
//  }
//}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class LocalNotification {
  static Future<void> showNotification(dynamic payload) async {
    // Parsing data notifikasi
    print(payload);
    final dynamic data = jsonDecode(payload['data']['data']);
    final dynamic notification = jsonDecode(payload['data']['notification']);

    // Parsing ID Notifikasi
    final int idNotification = data['id'] != null ? int.parse(data['id']) : 1;
//    final String idNotification = data['id'] != null ? data['id'] : "1";
    print(idNotification);

    // Daftar jenis notifikasi dari aplikasi.
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'BBD', 'Notification', 'All Notification is Here',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    // Menampilkan Notifikasi
    await flutterLocalNotificationsPlugin.show(
        idNotification, notification['title'], notification['body'], platformChannelSpecifics,
        payload: data['type']);
  }

  Future<void> notificationHandler(BuildContext context) async {
    // Pengaturan Notifikasi
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    // Handling notifikasi yang di tap oleh pengguna
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            routeToWidget(context,ListNotifPage()).then((value) {
              setPotrait();
            });
          }
        });
  }
}