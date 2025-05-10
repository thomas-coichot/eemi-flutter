import 'package:flutter/material.dart';
import 'package:flutter_5_wd/config/constants.dart';
import 'package:flutter_5_wd/config/router.dart';
import 'package:flutter_5_wd/config/theme.dart';
import 'package:flutter_5_wd/notifiers/session_notifier.dart';
import 'package:flutter_5_wd/notifiers/theme_notifier.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  MultiProvider multiProvider = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => SessionNotifier()),
    ],
    child: const MyApp(),
  );
  runApp(multiProvider);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
}
