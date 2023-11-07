import 'package:flutter/material.dart';
import 'package:product_app/model/fb_user.dart';
import 'package:product_app/service/firebase_manager.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final FirebaseManager _manager = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: _manager.getFbUser(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final FbUser user = snapshot.data!;
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      foregroundImage: NetworkImage(
                          user.image ?? ""
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('${user.email}',style: TextStyle(fontSize: 30)),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: () {
                      _logOut(context);
                    }, child: Text("Log out"),style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),)
                  ],
                )
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
  void _logOut(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Do you want to sign out?"),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Cancel")),
        TextButton(onPressed: () {
          _manager.logOut().then((value) {
            Navigator.of(context).popUntil((route) => false);
          });
        }, child: const Text("Yes")),
      ],
    ));
  }
}
