import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_page.dart';
import 'package:todo_app/pages/completed_tasks_page.dart';
import 'package:todo_app/pages/home_page.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/pages/tasks_not_done_page.dart';
import 'firebase_options.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppWrapper());
}

// main() => runApp(const AppWrapper());

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add-task':(context) => const AddPage(),
        '/completed-tasks':(context) => const CompletedTasksPage(),
        '/tasks-not-done':(context) => const TasksNotDonePage(),
      },
    );
  }
}