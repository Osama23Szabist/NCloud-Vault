import 'package:flutter/material.dart';
import 'nav_bar.dart';

class MakePassword extends StatefulWidget{
  @override
  State<MakePassword> createState() => _MakePasswordState();
}
class _MakePasswordState extends State<MakePassword>{
  String password = "";
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: password); // prefill here
  }
  @override
  void dispose() {
    _controller.dispose(); // always dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      drawer: CustomDrawer(currentPage: "make password"),
      body: Container(
        child: Padding(padding: .all(16),
            child: Column(
        children: [
          TextField(
            decoration: InputDecoration(label: Text("Password name"), border: OutlineInputBorder()),
          ),
          SizedBox(height: 20,),
          TextField(decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Description of the password"),),
          SizedBox(height: 20,),
          TextField(decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Url of the site"),),
          SizedBox(height: 20,),
          TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Username"),),
          SizedBox(height: 20,),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    password = "Auto generated password";
                    _controller.text = password;
                  });
                },
              ),
            ),
          ),
        ],),),
      ),
    );
  }
}