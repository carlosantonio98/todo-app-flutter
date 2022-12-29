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
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Todo app', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 35.0 )),

            ClipRRect(
              child: Container(
                width: 40.0,
                height: 40.0,
                child: Image.asset( 'assets/logo.png' ),
              ),
            ),

            SizedBox( height: 20.0 ),

            ElevatedButton(
              child: Text('Inicia con Google'),
              onPressed: () async {
                await authService.googleSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}