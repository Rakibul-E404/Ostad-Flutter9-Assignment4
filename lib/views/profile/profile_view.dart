import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ostad_flutter9_assignment4/services/auth_service.dart';
import 'package:ostad_flutter9_assignment4/views/profile/profile_edit.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            child: Text(
              user?.firstName.substring(0, 1) ?? 'U',
              style: TextStyle(fontSize: 40),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '${user?.firstName} ${user?.lastName}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(user?.email ?? 'No email'),
          SizedBox(height: 30),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileEditScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => Provider.of<AuthService>(context, listen: false).logout(),
          ),
        ],
      ),
    );
  }
}