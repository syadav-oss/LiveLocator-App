import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? loggedinuser;

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  final userlocation = FirebaseFirestore.instance.collection("location");
  late String name, email, uid, location;
  void getcurrentuser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getcurrentuser();
  }

  Future<void> userdata() async {
    final uid = loggedinuser!.uid;
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    DocumentSnapshot loc = await userlocation.doc(uid).get();
    name = ds.get('name');
    email = ds.get('email');
    location = loc.get('location');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Porfile Page',
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30,),
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person,size: 50,),
                ),
                SizedBox(height: 50),
                FutureBuilder(
                  future: userdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text('loading');
                    return Column(
                      children: [
                        Text(
                          "$name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          "$email",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          "$location",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        )
                      ],
                    );
                  },
                ),
                Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0))
              ],
            ),
          ),
        ));
  }
}