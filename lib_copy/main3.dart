import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import 'package:todo_app/services/auth.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({ super.key });

  @override
  _AppState createState() => _AppState();
}


class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // Rutas
          '/':(context) => const HomePage()
        },
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth con Provider',
        home: Consumer(
          builder: (context, AuthService authService, _) {
            switch (authService.status) {
              case AuthStatus.Uninitialized:
                return const Text('Cargando');
              case AuthStatus.Authenticated:
                return const HomePage();
              case AuthStatus.Authenticating:
                return const SignInPage();
              case AuthStatus.Unauthenticated:
                return const SignInPage();
            }
          },
        )
      ),
    );
  }
}

