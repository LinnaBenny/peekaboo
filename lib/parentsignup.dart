import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master/loginparent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RegisterPageParent(),
      },
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password, List<String> childrenEmails) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

     
      await _firestore.collection('parents').doc(userCredential.user!.uid).set({
        'email': email,
        'children': childrenEmails, 
      });

      return userCredential.user;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }
}

class RegisterPageParent extends StatefulWidget {
  @override
  _RegisterPageParentState createState() => _RegisterPageParentState();
}

class _RegisterPageParentState extends State<RegisterPageParent> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _childrenEmailController = TextEditingController();
  List<String> childrenEmails = [];
  String errorMessage = '';

  void _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        errorMessage = "Passwords do not match!";
      });
      return;
    }

    User? user = await _authService.signUpWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
      childrenEmails,
    );

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPageParent()),
      );
    } else {
      setState(() {
        errorMessage = "Failed to sign up. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'image/parentpic.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: 600,
                width: 500,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextFieldWithLabel('Username', controller: _usernameController),
                    SizedBox(height: 10),
                    _buildTextFieldWithLabel('Email', controller: _emailController),
                    SizedBox(height: 10),
                    _buildTextFieldWithLabel('Password', controller: _passwordController, isObscure: true),
                    SizedBox(height: 10),
                    _buildTextFieldWithLabel('Confirm Password', controller: _confirmPasswordController, isObscure: true),
                    SizedBox(height: 10),
                    Text('Children Email Addresses:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _childrenEmailController,
                            decoration: InputDecoration(
                              labelText: 'Child Email',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              String childEmail = _childrenEmailController.text;
                              if (childEmail.isNotEmpty) {
                                childrenEmails.add(childEmail);
                                _childrenEmailController.clear();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _register,
                      child: Text('SignUp'),
                    ),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPageParent()),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithLabel(String label, {bool isObscure = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 2),
        TextField(
          controller: controller,
          obscureText: isObscure,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
