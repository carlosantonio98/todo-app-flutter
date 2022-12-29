import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/add_page.dart';
import 'package:todo_app/pages/completed_tasks_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import 'package:todo_app/pages/tasks_not_done_page.dart';
import 'package:todo_app/services/auth_service.dart';

//void main() => runApp(const App());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MaterialAppCustom(),
    );
  }
}


class MaterialAppCustom extends StatelessWidget {
  const MaterialAppCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: {
        '/add-task':(context) => const AddPage(),
        '/completed-tasks':(context) => const CompletedTasksPage(),
        '/tasks-not-done':(context) => const TasksNotDonePage(),
      },
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
    );
  }
}

