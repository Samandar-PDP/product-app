import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/screens/main_screen.dart';
import 'package:product_app/service/firebase_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  XFile? _xFile;
  final _picker = ImagePicker();

  bool _isLoading = false;
  final _manager = FirebaseManager();

  void _register() {
    setState(() {
      _isLoading = true;
    });
    _manager.register(File(_xFile?.path ?? ""), email.text, password.text)
    .then((value) =>  {
      if(value == "Success") {
        Navigator.of(context)
            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainScreen()), (route) => false)
      } else {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$value error")))
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register")
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _xFile == null ? InkWell(
                  onTap: () async {
                    final file = await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      _xFile = XFile(file?.path ?? "");
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 3)
                    ),
                    child: Icon(Icons.image,color: Colors.white,),
                  ),
                ) : CircleAvatar(
                  radius: 100,
                  foregroundImage: FileImage(File(_xFile?.path ?? "")),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email'
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: password,
                  decoration: const InputDecoration(
                    hintText: 'Password'
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading ? const Center(
                  child: CircularProgressIndicator(),
                ) : ElevatedButton(onPressed: _register, child: const Text("Register"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
