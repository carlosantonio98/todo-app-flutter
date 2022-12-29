import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [

          const DrawerHeader(
            decoration: BoxDecoration( color: Colors.blueAccent ),
            child: Text( 'Opciones', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18.0 ), ),
          ),

          ListTile(
            leading: const Icon( Icons.home ),
            title: const Text( 'Inicio' ),
            onTap: () => Navigator.pop( context ),
          ),

          ListTile(
            leading: const Icon( Icons.check_box_outlined ),
            title: const Text( 'Tareas realizadas' ),
            onTap: () => Navigator.pushNamed( context, '/completed-tasks' ),
          ),

          ListTile(
            leading: const Icon( Icons.check_box_outline_blank ),
            title: const Text( 'Tareas por hacer' ),
            onTap: () => Navigator.pushNamed( context, '/tasks-not-done' ),
          ),

        ],
      ),
    );
  }
}
