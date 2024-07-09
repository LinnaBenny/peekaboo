import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master/age.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/age': (context) => AgeSelectionPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'image/macro.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Peekaboo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 48,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
           /* Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'image/logo.png', 
                height: 120,
                width: 120,
              ),
            ),*/
            SizedBox(height: 12),
            Center(
              child: Container(
                height: 285,
                width: 320,
                decoration: BoxDecoration(
                  color: Color.fromARGB(187, 245, 244, 244),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      _buildTextFieldWithLabel('Username', _usernameController),
                      SizedBox(height: 8),
                      _buildTextFieldWithLabel('Password', _passwordController, isObscure: true),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          print('Login button pressed'); 
                          await _signInWithEmailAndPassword(_usernameController.text, _passwordController.text);
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildTextFieldWithLabel(String label, TextEditingController controller, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
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

  Future<void> _signInWithEmailAndPassword(String username, String password) async {
    try {
      QuerySnapshot querySnapshot = 
      await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        String email = userDoc['email'];
        UserCredential userCredential = 
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        print('User signed in: ${userCredential.user!.email}');
        Navigator.pushReplacementNamed(context, '/age');
      } else {
        print('User not found');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid username or password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      
      print('Error signing in: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('An error occurred while logging in: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
