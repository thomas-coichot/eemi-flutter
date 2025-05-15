import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../config/router.dart';
import '../../notifiers/theme_notifier.dart';
import '../../utils.dart';
import 'bottom_navigation.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();

    final AppBar appBar = AppBar(
      title: const Text(appName),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.message_outlined),
        ),
      ],
    );

    if (isLargeScreen(context)) {
      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.post_add_sharp),
                          title: Text('Posts'),
                          onTap: () {
                            context.go(rtAdminPosts);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.group),
                          title: Text('Users'),
                          onTap: () {
                            context.go(rtAdminUsers);
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.login),
                    title: Text('Se connecter'),
                    onTap: () {
                      context.go(rtLogin);
                    },
                  ),
                  Wrap(
                    spacing: 4,
                    children: ThemeMode.values.map((itemTheme) {
                      return ChoiceChip(
                        selected: themeNotifier.themeMode == itemTheme,
                        onSelected: (_) {
                          _onTapTheme(context, itemTheme);
                        },
                        label: Text(_labelThemeMode(itemTheme)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  void _onTapTheme(BuildContext context, ThemeMode themeMode) {
    final ThemeNotifier themeNotifier = context.read<ThemeNotifier>();

    themeNotifier.changeTheme(themeMode);
  }

  String _labelThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
      default:
        return 'Système';
    }
  }
}
