import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: const TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87 ),
            ),
            const SizedBox( height: 10 ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87 ),
            ),
            const SizedBox( height: 30 ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'Log out',
                style: TextStyle( color: Colors.white, fontSize: 15 ),
              ),
              onPressed: () {
                authService.signOut();
              },
            )

          ],
        ),
      )
    );
  }
}