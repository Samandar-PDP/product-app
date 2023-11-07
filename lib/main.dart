import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_app/auth/login_screen.dart';
import 'package:product_app/screens/main_screen.dart';
import 'package:product_app/service/firebase_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(ProductApp());
}
class ProductApp extends StatelessWidget {
  ProductApp({super.key});
  final FirebaseManager _manager = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      color: const Color(0xFF0AB00E),
      home: _manager.getUser() == null ? const LoginScreen() : const MainScreen(),
    );
  }
}
