import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_app/screens/main_screen.dart';
import 'package:product_app/service/firebase_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseManager _manager = FirebaseManager();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false;

  void login() {
    setState(() {
      _isLoading = true;
    });
    _manager.login(email.text, password.text).then((value) {
      if(value == "Success") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),
              const SizedBox(height: 20),
              _isLoading ? CircularProgressIndicator() : ElevatedButton(onPressed: login, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
