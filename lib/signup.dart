import 'package:flutter/material.dart';
import 'package:n_cloud_vault/home.dart';
import 'package:n_cloud_vault/login_page.dart';
import 'nav_bar.dart';

class Signup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      drawer: CustomDrawer(currentPage: "Signup"),
      body: Container(
        child: Padding(padding: .all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('NCloud Vault'),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(labelText: "Email",border: OutlineInputBorder(),),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(labelText: "Username",border: OutlineInputBorder(),),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(labelText: "Password",border: OutlineInputBorder(),),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(labelText: "Confirm Password",border: OutlineInputBorder(),),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));}, child: Text("Login")),
                ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));}, child: Text("Signup")),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}

