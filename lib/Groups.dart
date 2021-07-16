import 'package:chat_app/Search.dart';
import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  const Group({ Key? key }) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a group'),
      ),
     // body:
     floatingActionButton: FloatingActionButton(
       onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Search())),
       child: Icon(Icons.add),
     ),
      );
  }
}