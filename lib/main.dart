import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/notification/my_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main_page.dart';

Future<void> _firebaseMesagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Message___${message.notification!.title}");
  print("Message Body....${message.notification!.body}");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "firebase demo",
  "firebase messaing test",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMesagingBackgroundHandler);



  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.
  createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,

  );


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  MyNotification _myNotification = MyNotification();

  @override
  void initState() {

    super.initState();
    _myNotification.remoteMesageInApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Mainpage(),
    );
  }
}
