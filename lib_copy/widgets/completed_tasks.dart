import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/models/task.dart';

class CompletedTasks extends StatelessWidget {

  const CompletedTasks({ super.key });

  @override
  Widget build(BuildContext context) {

    /* return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric( horizontal: 18 ),
        children: tasks.map((TaskModel task) => TaskCard(title: task.name)).toList()
      ),
    ); */

    Stream<List<Task>> readTasks() => FirebaseFirestore.instance
        .collection('tasks')
        .where('done', isEqualTo: true)
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());
  
    void deleteTask( taskId ) {
      final docTask = FirebaseFirestore.instance
          .collection('tasks')
          .doc( taskId );

      //Delete doc(register in firebase)
      docTask.delete();

      const snackBar = SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Eliminado con éxito!')
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } 

    void updateTask( task ) {
      final docTask = FirebaseFirestore.instance
          .collection('tasks')
          .doc( task.id );

      // Update specific fields
      docTask.update({
        'done': !task.done
      });

      const snackBar = SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Actualizado con éxito!')
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    Widget buildTask(Task task) => Container(
      margin: const EdgeInsets.symmetric( vertical: 12),
      child: ListTile(
        onTap: () {
          updateTask( task );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: const EdgeInsets.symmetric( horizontal: 20, vertical: 5 ),
        tileColor: Colors.white,
        leading: Icon(
          (task.done) ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text( task.todo, style: TextStyle( fontSize: 16, color: Colors.black, decoration: (task.done) ? TextDecoration.lineThrough : null )),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const FaIcon( FontAwesomeIcons.trash ),
            onPressed: () {
              deleteTask( task.id );
            },
          ),
        ),
      ),
    );


    return StreamBuilder<List<Task>>(
      stream: readTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData) {
          final tasks = snapshot.data!;

          return Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric( horizontal: 18 ),
              children: tasks.map(buildTask).toList()
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}