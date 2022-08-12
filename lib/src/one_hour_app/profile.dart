import 'package:flutter/material.dart';
const int itemCount = 20;
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
      return ListTile(title: Text('item $index'),
      leading: const Icon(Icons.person),
      trailing: const Icon(Icons.select_all),
      onTap: () {
        
      },);
    });
  }
}
