import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import 'package:todo_app/services/auth_service.dart';

//void main() => runApp(const App());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({ super.key });

  @override
  _AppState createState() => _AppState();
}


class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Consumer(
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
        )
      ),
    );
  }
}

