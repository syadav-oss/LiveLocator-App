import 'package:chat_app/Googlemap.dart';
import 'package:chat_app/Groups.dart';
import 'package:chat_app/Location.dart';
import 'package:chat_app/Methods.dart';
import 'package:chat_app/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Homepage",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
     // endDrawer: Maindrawer(),
      body: Column(
        children: [
          SizedBox(height: 10),
       

          SizedBox(height: 10),
          Center(
            child: Container(
              height: 100,
              child: Text(
                "Welcome to Home page",
                style: TextStyle(
                  color: Colors.orange[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),


          SizedBox(height: 10),

          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Profile())),
            child: Text(
              "Profile",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30,),
         
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Location())),
            child: Text(
              "Location",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
         
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Googlemap())),
            child: Text(
              "Googlemaps",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),

          
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Group())),
            child: Text(
              "Groups",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

           SizedBox(height: 10),
          
           ListTile(
            //leading: Icon(Icons.logout),
            title: Center(
              child: Text(
                'logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () => logOut(context),
          ),
          
        ],
      ),
    );
  }
}
