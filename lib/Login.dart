import 'package:chat_app/CreateAccount.dart';
import 'package:chat_app/HomeScreen.dart';
import 'package:chat_app/Methods.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
      :SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height / 20,),
            Container(
              alignment: Alignment.centerLeft,
             
              width: size.width ,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios)),
              ),
      
            SizedBox(height: size.height / 100),
            Container(
              width: size.width / 1.1,
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                ),
            ),
      
            //SizedBox(height: size.height/1000),
           Container(
             width: size.width / 1.1,
             child: Text(
               'Sign in to continue!',
               style: TextStyle(
                 color: Colors.grey,
                 fontSize: 16,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ),
      
            SizedBox(height: size.height / 10),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, 'Enter valid email',Icons.email,_email)),
            
      
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "Enter password", Icons.lock, _password),
              ),
            ),
      
            SizedBox(height: size.height / 20),
            customButton(size),
      
            SizedBox(height: size.height / 20),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccount())),
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size){
    return GestureDetector(
      onTap: () {

        if(_email.text.isNotEmpty && _password.text.isNotEmpty){
          setState(() {
            isLoading = true;
          });

          logIn(_email.text,_password.text).then((user){
            if(user!=null){
              setState(() {
                isLoading = false;
              });
              print('Login Successful');
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            }else{
              print('Login failed');
              setState(() {
                isLoading = false;
              });
            }
          });
        }else{
          print('Enter email and password');
        }

      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget field(Size size, String hintText, IconData icon, TextEditingController cont){
    return Container(
        height: size.height / 15,
        width: size.width / 1.1,
        child: TextField(
          controller: cont,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey,),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
  }
}