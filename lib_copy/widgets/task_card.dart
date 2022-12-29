import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TaskCard extends StatelessWidget {
  String title;

  TaskCard({ required this.title, super.key });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric( vertical: 12),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: const EdgeInsets.symmetric( horizontal: 20, vertical: 5 ),
        tileColor: Colors.white,
        leading: const Icon(
          Icons.check_box,
          color: Colors.blue,
        ),
        title: Text( title, style: const TextStyle( fontSize: 16, color: Colors.black, decoration: TextDecoration.lineThrough )),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          // margin: EdgeInsets.symmetric(vertical: 12),
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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}