import 'package:flutter/material.dart';
import 'package:project/pages/profilepagethings/about_us.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info),
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
            onTap: () {
              // Check for updates
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text('About Us'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
        ],
      ),
    );
  }
}
