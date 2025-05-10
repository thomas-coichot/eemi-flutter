import 'package:flutter/material.dart';
import 'package:flutter_5_wd/notifiers/session_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../config/router.dart';
import '../../notifiers/theme_notifier.dart';
import '../../utils.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({required this.child, super.key});

  final Widget child;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();
    final SessionNotifier session = context.watch<SessionNotifier>();

    final appBar = AppBar(
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
                          _onTapTheme(itemTheme);
                        },
                        label: Text(_labelThemeMode(itemTheme)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) => _onTapNavigation(index, session),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: colorScheme.onSurface,
            ),
            label: 'Home',
          ),
          if (session.isAuthenticated())
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: colorScheme.onSurface,
              ),
              label: 'Mon compte',
            )
          else
            BottomNavigationBarItem(
              icon: Icon(
                Icons.login,
                color: colorScheme.onSurface,
              ),
              label: 'Se connecter',
            ),
        ],
      ),
    );
  }

  void _onTapNavigation(int index, SessionNotifier session) {
    switch (index) {
      case 0:
        return context.go(rtRoot);
      case 1:
        return context.go(session.isAuthenticated() ? rtAccount : rtLogin);
    }
  }

  void _onTapTheme(ThemeMode themeMode) {
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
