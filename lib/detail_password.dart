import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/password_model.dart';
import 'providers/auth_provider.dart';
import 'providers/password_provider.dart';

class DetailPasswordPage extends StatefulWidget {
  final Password password;

  DetailPasswordPage({required this.password});

  @override
  _DetailPasswordPageState createState() => _DetailPasswordPageState();
}

class _DetailPasswordPageState extends State<DetailPasswordPage> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _passwordController;
  late TextEditingController _urlController;
  late TextEditingController _usernameController;

  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.password.name);
    _descController = TextEditingController(text: widget.password.description);
    _passwordController = TextEditingController(text: widget.password.password);
    _urlController = TextEditingController(text: widget.password.url);
    _usernameController = TextEditingController(text: widget.password.username);
  }

  void _updatePassword() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final passwordProvider = Provider.of<PasswordProvider>(context, listen: false);

    final updatedPassword = Password(
      id: widget.password.id,
      name: _nameController.text,
      description: _descController.text,
      password: _passwordController.text,
      url: _urlController.text,
      username: _usernameController.text,
    );

    final success = await passwordProvider.updatePassword(
      authProvider.token!,
      widget.password.id,
      updatedPassword,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update')));
    }
  }

  void _deletePassword() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Password'),
        content: Text('Are you sure you want to delete this password?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final passwordProvider = Provider.of<PasswordProvider>(context, listen: false);

      final success = await passwordProvider.deletePassword(authProvider.token!, widget.password.id);
      if (success) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
        actions: [
          IconButton(icon: Icon(Icons.delete_outline, color: Colors.red), onPressed: _deletePassword),
          IconButton(icon: Icon(Icons.check), onPressed: _updatePassword),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Account Name',
                prefixIcon: Icon(Icons.label_outline),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username/Email',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscured = !_isObscured),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'URL',
                prefixIcon: Icon(Icons.link),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _updatePassword,
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
