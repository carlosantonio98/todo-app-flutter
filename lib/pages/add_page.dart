import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_appbar.dart';

import 'package:todo_app/models/task.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: <Widget>[
                CustomAppBar(allowBack: true),
                const CustomForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey       = GlobalKey<FormState>();
  final todoController = TextEditingController();

  Future createTask(Task task) async {
    final docTask = FirebaseFirestore.instance.collection('tasks').doc();
    task.id       = docTask.id;

    final json = task.toJson();
    await docTask.set(json);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: todoController,
              validator: (value)  => ( value!.isEmpty ) ? 'Por favor ingrese un texto' : null,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Ingrese la tarea a realizar",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final task = Task( todo: todoController.text.trim(), done: false, userId: authService.user.id );

                  createTask(task);

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom( backgroundColor: Colors.green, padding: const EdgeInsets.all(20.0) ),
              child: const Text('Guardar', style: TextStyle(fontSize: 17.0)),
            )
          ],
        ),
      ),
    );
  }
}
