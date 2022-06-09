import 'package:firebase_auth/firebase_auth.dart'; // connection to firebase
import 'package:flutter/material.dart';

import 'menu_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //login function
  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("No User found for that email");
      }
    }
    return user;
  } 
  @override
  Widget build(BuildContext context) {
    // textfield controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header text
            const Text(
            "DIAMOND'S",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // image logo
            Image.asset(
              'assets/images/images-1.png', height: 120
            ),

            // email form
            const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "User Email",
                    prefixIcon:Icon(Icons.mail, color:Colors.black), 
                  ),
                ),

                // password form
                const SizedBox(height: 26),
                TextField(
                  controller: _passwordController,
                  obscureText:true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "User Password",
                    prefixIcon:Icon(Icons.lock, color:Colors.black), 
                  ),
                ),

                const SizedBox(height: 12),
                const Text("Don't remember your password",
                style: TextStyle(color: Colors.blue)),

                // login button
                const SizedBox(height: 60),
                Container(
                  width: double.infinity,
                  child:RawMaterialButton(
                    fillColor:Color.fromARGB(255, 35, 188, 226),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed:() async{
                      User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                      print(user);
                      if(user != null){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MenuScreen( email: _emailController.text)));
                      }
                    },
                    child:const Text("Login",
                      style:TextStyle(color:Colors.white,
                      fontSize: 22),
                    ),
                  )
                ),

          ],
        ),
      ),
    );
  }
}