import 'package:flutter/material.dart';
import 'package:master/netural/storywriting.dart';
import 'package:master/sad/sadkindness.dart';
import 'package:master/sad/sadorigami.dart';
import 'package:master/homescreen.dart';
import 'package:master/sad/sadfeelgood.dart';

class SelectOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SelectOptionButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, 
      height: 65,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class SadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/grey.jpeg'), 
            fit: BoxFit.cover,
          ),
        ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('image/logo.png', width: 100),
                    ],
                  ),
                  SizedBox(height: 20),
                  SelectOptionButton(
                    text: 'Feel Good Exercise',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SadExercise()));
                    },
                  ),
                  SizedBox(height: 20),
                  SelectOptionButton(
                    text: 'Origami Fun',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrigamiSad())); 
                    },
                  ),
                  SizedBox(height: 20),
                  SelectOptionButton(
                    text: 'Kindness Challenge',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Kindnessaction())); 
                    },
                  ),
                  SizedBox(height: 20),
                  SelectOptionButton(
                    text: 'ImageStoryWriting',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ImageStoryWriterPage()));
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Homepage()),
                        );  // Navigate back to the previous screen
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
