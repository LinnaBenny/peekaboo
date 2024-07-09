import 'package:flutter/material.dart';
import 'package:master/login.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

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
                'image/background.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack( 
            children: [
              Positioned( 
                top: 8,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Peekaboo',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 500,
                  width: 375,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🌟 Welcome! Lets Get Started'),
                        SizedBox(height: 6),
                        _buildTextFieldWithLabel('Username'),
                        SizedBox(height: 6),
                        _buildTextFieldWithLabel('Email id'),
                        SizedBox(height: 6),
                        _buildTextFieldWithLabel('Age'),
                        SizedBox(height: 6),
                        _buildTextFieldWithLabel('Password', isObscure: true),
                        SizedBox(height: 6),
                        _buildTextFieldWithLabel('Confirm Password', isObscure: true),
                        SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Sign In'),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder:(context) => LoginPage()),
                                  );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
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
              SizedBox(height: 12), // Add spacing below the container
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabel(String label, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: isObscure,
          style: TextStyle(fontSize: 14), 
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
