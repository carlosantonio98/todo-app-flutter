import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_appbar.dart';
import 'package:todo_app/widgets/completed_tasks.dart';

class CompletedTasksPage extends StatelessWidget {
  const CompletedTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          SafeArea(
            child: Column(
              children: <Widget> [
                CustomAppBar( allowBack: true ),
                const SizedBox(height: 15.0),
                const Text('Tareas completadas'),
                const SizedBox(height: 15.0),
                const CompletedTasks(),
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