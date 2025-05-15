import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/router.dart';
import '../../notifiers/session_notifier.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final SessionNotifier session = context.watch<SessionNotifier>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
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
    );
  }

  void _onTapNavigation(int index, SessionNotifier session) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        return context.go(rtRoot);
      case 1:
        return context.go(session.isAuthenticated() ? rtAccount : rtLogin);
    }
  }
}
