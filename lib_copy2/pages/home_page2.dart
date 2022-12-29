import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_appbar.dart';
import 'package:todo_app/widgets/custom_drawer.dart';
import 'package:todo_app/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [

          SafeArea(
            child: Column(
              children: <Widget>[
                CustomAppBar(),
                const TaskList(),
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