import 'package:flutter/material.dart';
import 'package:flutter_5_wd/config/router.dart';
import 'package:flutter_5_wd/notifiers/session_notifier.dart';
import 'package:flutter_5_wd/providers/auth_provider.dart';
import 'package:flutter_5_wd/widgets/buttons/loading_button.dart';
import 'package:flutter_5_wd/widgets/fields/custom_text_field.dart';
import 'package:flutter_5_wd/widgets/fields/password_field.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            CustomTextField(
              controller: _emailController,
              label: 'Email',
            ),
            PasswordField(
              controller: _passwordController,
              label: 'Password',
            ),
            LoadingButton(
              label: 'Se connecter',
              isSubmitted: _isSubmitted,
              onPressed: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Veuillez renseigner tous les champs'),
      ));
      return;
    }

    setState(() {
      _isSubmitted = true;
    });

    final session = context.read<SessionNotifier>();

    try {
      final response = await AuthProvider().login(
        data: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (!mounted) {
        return;
      }

      session.onAuthenticationSuccess(response);

      context.go(rtRoot);
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Impossible de se connecter'),
      ));
    }
  }
}
