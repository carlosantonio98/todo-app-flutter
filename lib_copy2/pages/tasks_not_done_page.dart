import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_appbar.dart';
import 'package:todo_app/widgets/tasks_not_done.dart';

class TasksNotDonePage extends StatelessWidget {
  const TasksNotDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          SafeArea(
            child: Column(
              children: <Widget>[
                CustomAppBar( allowBack: true ),
                const SizedBox(height: 15.0),
                const Text('Tareas pendientes por realizar'),
                const SizedBox(height: 15.0),
                const TasksNotDone(),
              ],
            ),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar nueva tarea',
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}