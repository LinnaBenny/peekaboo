import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:master/happy/happyfeelgood.dart';
import 'package:master/happy/origamifun.dart';
import 'package:master/happy/happyhub.dart';
import 'package:master/happy/kindnesshappy.dart';

class CompletedTask {
  final String name;
  final String description;
  final bool isCompleted;

  CompletedTask({
    required this.name,
    required this.description,
    this.isCompleted = false,
  });
}

class SelectOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isCompleted;
  final Function(String) markTaskAsCompleted;

  const SelectOptionButton({
    required this.text,
    required this.onPressed,
    this.isCompleted = false,
    required this.markTaskAsCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 65,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
          if (!isCompleted) {
            markTaskAsCompleted(text);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: isCompleted ? Colors.green : Colors.white,
          onPrimary: isCompleted ? Colors.white : Colors.black,
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

class HappyPage extends StatelessWidget {
  void markTaskAsCompleted(String taskName) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        String userId = user.uid;

        await FirebaseFirestore.instance.collection('completed_tasks').add({
          'userId': userId,
          'name': taskName,
          'completed_at': DateTime.now(),
        });

        print('Task marked as completed for user: $userId');
      } else {
        print('User is not authenticated');
      }
    } catch (e) {
      print('Error marking task as completed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Container(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HappyExercise()));
                },
                markTaskAsCompleted: markTaskAsCompleted,
              ),
              SizedBox(height: 20),
              SelectOptionButton(
                text: 'Origami Fun',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrigamiHappy()));
                },
                markTaskAsCompleted: markTaskAsCompleted,
              ),
              SizedBox(height: 20),
              SelectOptionButton(
                text: 'Kindness Challenge',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KindnessJarScreen()));
                },
                markTaskAsCompleted: markTaskAsCompleted,
              ),
              SizedBox(height: 20),
              SelectOptionButton(
                text: 'Happy Hub',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VideoEx()));
                },
                markTaskAsCompleted: markTaskAsCompleted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
