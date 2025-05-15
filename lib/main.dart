import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_5_wd/config/constants.dart';
import 'package:flutter_5_wd/config/router.dart';
import 'package:flutter_5_wd/config/theme.dart';
import 'package:flutter_5_wd/notifiers/session_notifier.dart';
import 'package:flutter_5_wd/notifiers/theme_notifier.dart';
import 'package:flutter_5_wd/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'firebase_options.dart';
import 'services/platform/platform_default.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(NotificationService.onBackgroundMessage);

  MultiProvider multiProvider = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => SessionNotifier()),
    ],
    child: const ToastificationWrapper(
      child: MyApp(),
    ),
  );
  runApp(multiProvider);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _listenNotification();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themeData,
      darkTheme: darkThemeData,
      themeMode: themeNotifier.themeMode,
    );
  }

  void _listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message en premier plan: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message cliqué: ${message.data}');
    });
  }
}
