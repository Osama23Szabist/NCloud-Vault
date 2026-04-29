import 'package:flutter/material.dart';
import 'home.dart';

class DetailPasswordPage extends StatefulWidget {
  final String passwordId;

  DetailPasswordPage({required this.passwordId});

  @override
  _DetailPasswordPageState createState() => _DetailPasswordPageState();
}

class _DetailPasswordPageState extends State<DetailPasswordPage> {
  // Example password data
  String name = 'Email Account';
  String description = 'My email password';
  String password = 'ThisIsSecure123';
  String url = "password.com";
  String username = "osama";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${widget.passwordId}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: TextEditingController(text: name),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: TextEditingController(text: description),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              controller: TextEditingController(text: password),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'url'),
              controller: TextEditingController(text: url),
              onChanged: (value) {
                setState(() {
                  url = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'username'),
              controller: TextEditingController(text: username),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Name: $name, Description: $description, Password: $password, url: $url, username: $username');
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text('Save Changes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Deleted password with ID: ${widget.passwordId}');
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}