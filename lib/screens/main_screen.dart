import 'package:flutter/material.dart';
import 'package:product_app/service/firebase_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseManager _manager = FirebaseManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products")
      ),
      body: Center(
        child: Text(
          _manager.getUser()?.email ?? "Email",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
