import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart'; // connection to firebase
import 'package:flutter/material.dart';
import 'package:uas_firebase/login_page.dart';
import 'package:http/http.dart' as http; // import http package

class MenuScreen extends StatefulWidget {
  String email;
   MenuScreen({ Key? key,required this.email }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String data;
  var item;

  @override
  // Init State
  void initState() { 
    super.initState();
    getData();
  }

  // function to hit api and get data from api
  getData() async {
    var url = "https://62935afb7aa3e6af1a0a14d1.mockapi.io/api/v1/diamonds"; // sample mock api
    http.Response response =
        await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      data = response.body; //get response code from api
      setState(() {
        item = jsonDecode(data); //get all the data from api
        print(item.length); // print length of data
      });
    } else {
      print(response.statusCode);
    }
  }

  // function to logout when float button was clicked
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 35, 188, 226),
        title: Text("Diamond's",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        
      //  floating Button using for signout
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signOut();
        },
        child: Icon(Icons.logout_rounded),
        backgroundColor: Colors.red,
      ),
  
      // List view data
      body: ListView.builder(
        itemCount: item == null ? 0 : item.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                jsonDecode(data)[index]['url'], // get image url from json data api
                fit: BoxFit.fill,
                width: 100,
                height: 500,
                alignment: Alignment.center,
              ),
              title: Text(jsonDecode(data)[index]['title']), // get name product of json data api
              subtitle: Text(jsonDecode(data)[index]['price']), // get price product of json data api
            ),
          );
        },
      ),
    );
  }
}