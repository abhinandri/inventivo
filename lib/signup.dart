import 'package:flutter/material.dart';
import 'package:project/db_function/db_function.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

const signUp = 'signup';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText2 = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
                Color(0xFFA1F6FB),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Text(
                        'SignUp',
                        style:
                            TextStyle(fontSize: 30, color: Color(0xFF17A2B8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your username';
                        } else if (value.length < 3) {
                          return 'Username must be at least 3 character';
                        }
                        return null;
                      },
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Username '),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your email';
                        } else if (!value.contains('@') ||
                            (!value.contains('.'))) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: _obscureText2,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text('Password'),
                          suffixIcon: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: Icon(_obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                    ),
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF17A2B8)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 20),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkSignup(context);
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkSignup(BuildContext context) async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final user = UserModel(name: username, email: email, password: password);

    //save data to sharedpreference
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(signUp, true);
    await sharedPref.setString('username', _usernameController.text);
    await sharedPref.setString('email', _emailController.text);
    await sharedPref.setString('password', _passwordController.text);
    await addUser(user);

    // Increment the index value
    //show success msg
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('signup succesfull'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green));

    // Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
}
