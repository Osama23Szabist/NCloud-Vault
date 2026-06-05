import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'home.dart';
import 'providers/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  final String currentPage;

  CustomDrawer({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            accountName: Text("Vault User", style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text(authProvider.isAuthenticated ? "Secure Account" : "Not Logged In"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.indigo),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("Home"),
            selected: currentPage == "Home Page",
            onTap: () {
              Navigator.pop(context);
              if (currentPage != "Home Page") {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              // Implementation for settings could go here
            },
          ),
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Sign Out", style: TextStyle(color: Colors.red)),
            onTap: () async {
              await authProvider.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
