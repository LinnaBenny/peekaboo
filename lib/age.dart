import 'package:flutter/material.dart';
import 'package:master/assessment.dart'; 
import 'package:master/child/homepage.dart';

class AgeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/agepic.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Please select your age group',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  Image.asset('image/logo.png', width: 100),
                ],
              ),
              SizedBox(height: 30),
              AgeOptionButton(
                text: '5-7 Years',
                
                onPressed: () {
                  // Handle selection of age range 5-8
                  print('Age range 5-8 selected');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChildHome()));
                },
              ),
              SizedBox(height: 20),
              AgeOptionButton(
                text: '8-12 Years',
                onPressed: () {
                  // Handle selection of age range 8-12
                  print('Age range 9-12 selected');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AssessmentPage())); // Navigate to the assessment page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgeOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AgeOptionButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
