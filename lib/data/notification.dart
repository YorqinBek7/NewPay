import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._();
  factory NotificationService() => instance;
  NotificationService._();

  Dio dio = Dio(
    BaseOptions(
      sendTimeout: 25000,
      connectTimeout: 25000,
    ),
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  permissoinNotif() async {
    var messInstance = FirebaseMessaging.instance;
    await messInstance.requestPermission();
    Helper.requestPermission(setting: Permission.notification);
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  init() async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosinitialization = const DarwinInitializationSettings();

    var notifInitialization = InitializationSettings(
      android: androidInitialization,
      iOS: iosinitialization,
    );

    flutterLocalNotificationsPlugin.initialize(
      notifInitialization,
      onDidReceiveNotificationResponse: (details) => {},
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails(
        'New Pay',
        'New Pay',
        importance: Importance.high,
      );
      var notificatoinDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificatoinDetails,
        payload: message.data['title'],
      );
    });
  }

  Future backGroundhandler(RemoteMessage message) async {
    FirebaseMessaging.onBackgroundMessage((message) async {
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails(
        'New Pay',
        'New Pay',
        importance: Importance.high,
      );
      var notificatoinDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificatoinDetails,
        payload: message.data['title'],
      );
    });
  }

  sendNotification() async {
    dio.post('https://fcm.googleapis.com/fcm/send');
  }
}
