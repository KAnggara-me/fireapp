import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final dataCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();
  final titleCtrl = StreamController<String>.broadcast();

  //notif
  notif() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      provisional: false,
      announcement: false,
      criticalAlert: false,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      forground();
      background();
      terminate();
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }

    _firebaseMessaging
        .getToken()
        // ignore: avoid_print
        .then((value) => print("FcM Token :  $value \n\n"));
  }

  forground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }
      if (message.data.isNotEmpty) {
        dataCtrl.sink.add("event.data");
      }
      if (notification != null) {
        if (kDebugMode) {
          print('Message also contained a notification: $notification');
        }
        titleCtrl.sink.add(notification.title!);
        bodyCtrl.sink.add(notification.body!);
      }
    });
  }

  background() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Background => ");
      }
      if (message.data.isNotEmpty) {
        dataCtrl.sink.add('message.data');
      }
      if (message.notification != null) {
        titleCtrl.sink.add(message.notification!.title!);
        bodyCtrl.sink.add(message.notification!.body!);
      }
    });
  }

  terminate() async {
    RemoteMessage? initialMsg =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMsg != null) {
      if (kDebugMode) {
        print("Terminated => ");
      }
      if (initialMsg.data.isNotEmpty) {
        dataCtrl.sink.add("initialMsg.data");
      }

      if (initialMsg.notification != null) {
        titleCtrl.sink.add(initialMsg.notification!.title!);
        bodyCtrl.sink.add(initialMsg.notification!.body!);
      }
    }
  }

  void dispose() {
    dataCtrl.close();
    bodyCtrl.close();
    titleCtrl.close();
  }
}
