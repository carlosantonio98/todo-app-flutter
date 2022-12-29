import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Google login'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only( left: 20, right: 20, top: size.height * 0.2, bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hello, \nGoogle sign-in', style: TextStyle( fontSize: 30 )),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  AuthService().googleSignIn();
                },
                child: Image(width: 100, image: AssetImage('assets/google.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}