import 'dart:async';
import 'package:flutter/material.dart';
import 'package:n_cloud_vault/home.dart';
import 'nav_bar.dart';
import 'signup.dart';
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    // startTypingAnimation();
  }
  String title = "NCloud Vault";
  String final_text = "NCloud Vault";
  int count = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: NavBar(),
      drawer: CustomDrawer(currentPage: 'login'),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(16.0),
        child : Column(
          children: [
            SizedBox(height: 20,),
            Text(title),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(labelText: "Username",border: OutlineInputBorder(),),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: "Password",border: OutlineInputBorder(),),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));}, child: Text("Login")),
                ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Signup()));}, child: Text("Signup")),
              ],
            ),
          ],
        )
        )
      ),
    );
  }
  void startTypingAnimation(){
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        title += final_text.substring(count,count+1);
        count += 1;
        if (count == final_text.length){
          count = 0;
          title = "";
        }
      });
    });
  }
}
