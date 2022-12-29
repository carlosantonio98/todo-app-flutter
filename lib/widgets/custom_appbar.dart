import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  bool allowBack;

  CustomAppBar({ this.allowBack = false, super.key });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      padding: const EdgeInsets.only( top: 5.0, bottom: 5.0 ),
      width: double.infinity,
      // color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          const SizedBox(width: 15.0,),

          IconButton(
            onPressed: () => allowBack ? Navigator.pushNamed(context, '/') : Scaffold.of(context).openDrawer(), 
            icon: allowBack ? const FaIcon(FontAwesomeIcons.arrowLeft) : const FaIcon(FontAwesomeIcons.barsStaggered)
          ),

          const Spacer(),

          const Text('Todo App', style: TextStyle( fontWeight: FontWeight.bold )),

          const Spacer(),

          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              child: Image.network( authService.user.photoURL ),
            ),
          ),

          const SizedBox(width: 15.0,)
        ],
      ),
    );
  }
}
