import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home.dart';
import 'dart:async';

import 'package:n_cloud_vault/login_page.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("NCloud Vault"),
      backgroundColor: Colors.blue,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomDrawer extends StatelessWidget{
  final String currentPage;

  CustomDrawer({required this.currentPage});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(child: Text("Welcome {users name will be here}"),),
          ListTile(
            title: Text("Home Page"),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));},
          ),
          if (currentPage != "Signup" && currentPage != "login")
            ListTile(
              title: Text("SignOut"),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));},
            ),
          ListTile(
            title: Text("Settings"),
            onTap: () {Navigator.pop(context);},
          ),
        ],
      ),
    );
  }
}
