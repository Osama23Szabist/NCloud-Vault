import "package:flutter/material.dart";
import 'nav_bar.dart';
import 'detail_password.dart';
import 'make_password.dart';
class Password {
  final String id;
  final String name;
  final String description;

  Password({required this.id, required this.name, required this.description});
}



class Home extends StatelessWidget{
  final List<Password> passwords = [
    Password(id: '1', name: 'Email', description: 'My email password'),
    Password(id: '2', name: 'Bank account', description: 'Bank password'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MakePassword()));
        },
        child: Icon(Icons.add),
      ),
      appBar: NavBar(),
      drawer: CustomDrawer(currentPage: "Home Page"),
      body: Container(
        child: ListView.builder(
        itemCount: passwords.length,
        itemBuilder: (context, index) {
          final password = passwords[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(password.name),
              subtitle: Text(password.description),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => DetailPasswordPage(passwordId: password.id)));
              },
            ),
          );
        },
      ),

      ),
    );
  }
}