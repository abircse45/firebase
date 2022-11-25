import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyNotification {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "firebase demo",
    "firebase messaing test",
    importance: Importance.high,
    playSound: true,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void remoteMesageInApp() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      RemoteNotification? notification = remoteMessage.notification;

      AndroidNotification? android = remoteMessage.notification!.android;

      if (notification != null && android != null) {
        ///
        print("Message__${notification.title}");
        print("Message__${notification.body}");

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  playSound: true,
                  priority: Priority.high,
                  icon: "@mipmap/ic_launcher")),
        );
      }
    });
  }
}
