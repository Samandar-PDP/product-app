import 'package:flutter/material.dart';
import 'package:product_app/screens/add_screen.dart';
import 'package:product_app/screens/profile_screen.dart';
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
    return RefreshIndicator(
      displacement: MediaQuery.of(context).size.height / 6,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          actions: [
            IconButton(onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
            }, icon: Icon(Icons.person_outline_sharp))
          ],
        ),
        body: FutureBuilder(
          future: _manager.getProductList(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final data = snapshot.data?[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 70,
                      foregroundImage: NetworkImage(
                        data?.image ?? ""
                      ),
                    ),
                    title: Text(data?.name ?? "",style: TextStyle(fontSize: 25)),
                    subtitle: Text(data?.price.toString() ?? "0"),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddScreen()));
          },
          child: const Icon(Icons.shopping_basket_outlined),
        ),
      ),
    );
  }
}
