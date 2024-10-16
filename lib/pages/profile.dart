
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/db_function/db_function.dart';
import 'package:project/login.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/edit_profile.dart';
import 'package:project/pages/profilepagethings/privacypolicy.dart';
import 'package:project/pages/profilepagethings/settings.dart';
import 'package:project/pages/profilepagethings/termofuse.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _username;
  String? _email;
  String? _password;
  File? _profileImage;

  final List<String> _title = [
    'Settings',
    'Privacy Policy',
    'Terms and condition',
    'Logout',
  ];

  final List<IconData> _icons = [
    Icons.settings,
    Icons.privacy_tip_sharp,
    Icons.article,
    Icons.logout,
  ];

  final Color primaryColor = const Color(0xFF17A2B8);

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final user = await getUser();
    if (user != null) {
      setState(() {
        _username = user.name;
        _password = user.password;
        _email = user.email;
        if (user.photo != null) {
          _profileImage = File(user.photo!);
        }
      });
    }
  }

  void _onTileTapped(int index) {
    switch (_title[index]) {
      case 'Settings':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
        break;
      case 'Privacy Policy':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
        break;
      case 'Terms and condition':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsConditions()));
        break;
      case 'Logout':
        _confirmLogout();
        break;
    }
  }

  Future<void> _confirmLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Confirm Logout', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w400)),
          content: const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.black87)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: primaryColor)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _logout();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    final userBox = await Hive.openBox<UserModel>('user_db');
    final value = userBox.getAt(0);
    value!.isLoggedIn = false;
    userBox.putAt(0, value);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            
            colors: [
              Colors.white,
              Colors.white,
              primaryColor.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(),
                _buildContentSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: primaryColor.withOpacity(0.2),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: primaryColor,
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 80, color: Colors.white)
                      : null,
                ),
              ),
              
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _username ?? 'Username',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            _email ?? 'Email',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    username: _username ?? '',
                    password: _password ?? '',
                    email: _email ?? '',
                  ),
                ),
              );
              if (result != null) {
                _loadUserDetails();
              }
            },
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), 
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              'Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(_icons[index], color: index == 3 ? Colors.red : primaryColor),
                  title: Text(_title[index], style: TextStyle(color: index == 3 ? Colors.red : Colors.black87)),
                  trailing: Icon(Icons.chevron_right, color: primaryColor),
                  onTap: () => _onTileTapped(index),
                );
              },
              separatorBuilder: (context, index) => Divider(color: Colors.grey[300], height: 1),
              itemCount: _title.length,
            ),
          ),
        ],
      ),
    );
  }
}