import 'package:flutter/material.dart';
import 'package:flutter_5_wd/providers/user_provider.dart';
import 'package:flutter_5_wd/widgets/Smart_table.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return SmartTable<UserProvider>(
      provider: UserProvider(),
      title: 'Users',
      getTitle: (item) => item.email,
    );
  }
}
