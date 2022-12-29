import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({ super.key });

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Inicia con Google'),
          onPressed: () async {
            await authService.googleSignIn();
          },
        ),
      ),
    );
  }
}