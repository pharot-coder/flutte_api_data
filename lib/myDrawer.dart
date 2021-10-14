import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.network(
                "https://flutter.dev/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png"),
          ),
          ListTile(
            title: Text("Home"),
            onTap: () {},
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {},
            leading: Icon(
              Icons.person,
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text("Setting"),
            onTap: () {},
            leading: Icon(
              Icons.settings,
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text("Contact"),
            onTap: () {},
            leading: Icon(
              Icons.contact_mail,
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text("Log Out"),
            onTap: () {},
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
