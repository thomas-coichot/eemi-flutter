import 'package:flutter/material.dart';
import 'package:flutter_5_wd/notifiers/session_notifier.dart';
import 'package:flutter_5_wd/screens/admin/posts/posts_screen.dart';
import 'package:flutter_5_wd/screens/admin/users/users_screen.dart';
import 'package:flutter_5_wd/screens/security/login_screen.dart';
import 'package:flutter_5_wd/screens/user/home_screen.dart';
import 'package:flutter_5_wd/widgets/layouts/home_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

const rtRoot = '/';
const rtLogin = '/login';
const rtAccount = '/account';
const rtAdmin = '/admin';
const rtAdminPosts = '$rtAdmin/posts';
const rtAdminUsers = '$rtAdmin/users';

String? hasAdminPermissions(BuildContext context, GoRouterState state) {
  final session = context.read<SessionNotifier>();

  if (session.isAdmin()) {
    return null;
  }

  return rtRoot;
}

String? hasUserPermissions(BuildContext context, GoRouterState state) {
  final session = context.read<SessionNotifier>();

  if (session.isAuthenticated()) {
    return null;
  }

  return rtRoot;
}

final router = GoRouter(
  initialLocation: rtRoot,
  routes: [
    ShellRoute(
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
        return NoTransitionPage(
          child: HomeLayout(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: rtRoot,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              child: HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: rtLogin,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              child: LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: rtAccount,
          redirect: hasUserPermissions,
          builder: (BuildContext context, GoRouterState state) {
            final session = context.read<SessionNotifier>();

            return Column(
              children: [
                Text('Account'),
                Text(session.user!.getFullName()),
              ],
            );
          },
        ),
        GoRoute(
          path: rtAdminPosts,
          builder: (BuildContext context, GoRouterState state) {
            return AdminPostsScreen();
          },
        ),
        GoRoute(
          path: rtAdminUsers,
          builder: (BuildContext context, GoRouterState state) {
            return AdminUsersScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: rtLogin,
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
  ],
);
