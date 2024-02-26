import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vendor/utils/routes.dart'; // Assuming this is your custom routes file

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key? key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  static Future<User?> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for entered email");
        return null; // Handle user not found gracefully (optional)
      } else if (e.code == "wrong-password") {
        print("Incorrect password");
        return null; // Handle wrong password gracefully (optional)
      }
      return null; // Handle other errors (optional)
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  void moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = await login(
            email: _emailController.text,
            password: _passwordController.text,
            context: context);
        if (user != null) {
          Navigator.of(context).pushNamed(MyRoutes.homeRoute2);
        } else {
          _showAlertDialog("Incorrect credentials. Please try again.");
        }
      } on FirebaseAuthException catch (e) {
        print("Error logging in: ${e.code}"); // Log the error for debugging
        _showAlertDialog("An error occurred. Please try again later.");
      }
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(
          message,
          style: TextStyle(fontSize: 16), // Increase text size
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust to avoid bottom overflow issues

      appBar: AppBar(
        title: Text(
          'Stationery Vendor Login',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0, // Removes app bar shadow
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              // Use Stack for positioning
              children: [
                Column(
                  // Background column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/pencil.png",
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 32, // Increase text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "Enter Email Address",
                              labelText: "Email",
                              labelStyle: TextStyle(fontSize: 20),
                              hintStyle: TextStyle(fontSize: 18),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be Empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              hintStyle: TextStyle(fontSize: 18),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be Empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(MyRoutes.forgotPasswordRoute);
                            },
                            child: Row(
                              // Wrap Text inside a Row
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Align content to the left
                              children: [
                                Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Material(
                            color: Colors.blueAccent,
                            //shape: changeButton ? BoxShape.circle: BoxShape.rectangle ,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () => moveToHome(context),
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22, // Increase text size
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
