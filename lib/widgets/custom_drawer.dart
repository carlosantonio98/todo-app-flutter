import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [

          DrawerHeader(
            decoration: BoxDecoration( color: Colors.blueAccent ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( 'Opciones', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18.0 ), ),

                Spacer(),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: Image.network( authService.user.photoURL ),
                  ),
                ),

                Spacer(),

                Text( authService.user.displayName, style: TextStyle( fontWeight: FontWeight.w400, fontSize: 13.0 ), ),

                Text( authService.user.email, style: TextStyle( fontWeight: FontWeight.w400, fontSize: 13.0 ), ),
              ],
            )
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
          
          ListTile(
            leading: const Icon( Icons.door_back_door ),
            title: const Text( 'Salir' ),
            onTap: () => authService.signOut(),
          ),

        ],
      ),
    );
  }
}
