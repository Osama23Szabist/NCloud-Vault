import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nav_bar.dart';
import 'detail_password.dart';
import 'make_password.dart';
import 'providers/auth_provider.dart';
import 'providers/password_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.token != null) {
        Provider.of<PasswordProvider>(context, listen: false)
            .fetchPasswords(authProvider.token!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MakePassword()));
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      appBar: AppBar(
        title: Text('My Vault', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (authProvider.token != null) {
                passwordProvider.fetchPasswords(authProvider.token!);
              }
            },
          ),
        ],
      ),
      drawer: CustomDrawer(currentPage: "Home Page"),
      body: passwordProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : passwordProvider.passwords.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: () async {
                    if (authProvider.token != null) {
                      await passwordProvider.fetchPasswords(authProvider.token!);
                    }
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: passwordProvider.passwords.length,
                    itemBuilder: (context, index) {
                      final password = passwordProvider.passwords[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                            child: Icon(Icons.vpn_key, color: Colors.indigo),
                          ),
                          title: Text(
                            password.name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (password.username != null && password.username!.isNotEmpty)
                                Text(password.username!, style: TextStyle(fontSize: 13)),
                              Text(
                                password.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.chevron_right, color: Colors.grey),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPasswordPage(password: password),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_open, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'Your vault is empty',
            style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            'Add your first password to get started',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
