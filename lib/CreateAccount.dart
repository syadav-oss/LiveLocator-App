import 'package:chat_app/HomeScreen.dart';
import 'package:chat_app/Login.dart';
import 'package:chat_app/Methods.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({ Key? key }) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final TextEditingController _name = TextEditingController();
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
          width: size.width / 20,
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
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
             'Create Account to continue!',
             style: TextStyle(
               color: Colors.grey,
               fontSize: 16,
               fontWeight: FontWeight.w500,
             ),
           ),
         ),

          SizedBox(height: size.height / 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, 'Name',Icons.person,_name)),
          ),
          
           Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(size, 'Email',Icons.email,_email)),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Create password", Icons.lock,_password),
            ),
          ),

          SizedBox(height: size.height / 20),
          customButton(size),
          
          SizedBox(height: size.height / 20),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login())),
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )

          ],
          ),
      ),
    );
  }

  Widget customButton(Size size){
    return GestureDetector(
      onTap: () {
        
        if(_name.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty){
          setState(() {
            isLoading = true;
          });
          createAccount(_name.text, _email.text, _password.text)
          .then((user) {
            if(user != null){
              setState(() {
                isLoading = false;
              });
              print('Account created Successfully');
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            }else{
              setState(() {
                isLoading = false;
              });
              print('Account creation Failed');
            }
          });


        }else{
          print('Please enter Fields');
        }

      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          'Create Account',
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