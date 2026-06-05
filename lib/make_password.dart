import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/password_provider.dart';
import 'models/password_model.dart';

class MakePassword extends StatefulWidget {
  @override
  State<MakePassword> createState() => _MakePasswordState();
}

class _MakePasswordState extends State<MakePassword> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _urlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _generatePassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    final generated = List.generate(12, (index) => chars[(DateTime.now().microsecondsSinceEpoch + index) % chars.length]).join();
    setState(() {
      _passwordController.text = generated;
    });
  }

  void _savePassword() async {
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name and Password are required')));
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final passwordProvider = Provider.of<PasswordProvider>(context, listen: false);

    final newPassword = Password(
      id: '', // Backend will assign ID
      name: _nameController.text,
      description: _descController.text,
      password: _passwordController.text,
      url: _urlController.text,
      username: _usernameController.text,
    );

    final success = await passwordProvider.addPassword(authProvider.token!, newPassword);

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Password'),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: _savePassword),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Account Name",
                hintText: "e.g. Google, Bank, Netflix",
                prefixIcon: Icon(Icons.label_outline),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username/Email",
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _generatePassword,
                  tooltip: 'Generate Password',
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: "Website URL",
                prefixIcon: Icon(Icons.link),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _savePassword,
              icon: Icon(Icons.save),
              label: Text('Save Password'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
