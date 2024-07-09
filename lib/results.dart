import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master/happy/happyhome.dart';
import 'package:master/netural/neturalhome.dart';
import 'package:master/sad/sadhome.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultPages extends StatelessWidget {
  final String mood;
  final int totalMarks;

  const ResultPages(this.mood, this.totalMarks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/resultpic.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset(
                'image/logo.png',
                height: 120,
                width: 120,
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Guess what? Today's mood is like a weather forecast for our feelings! It's like our very own emotional adventure. Ready to find out?",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Your mood is : $mood",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Total Marks: $totalMarks",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 200, 
                height: 50, 
                child: FloatingActionButton(
                  onPressed: () => nextSolution(context),
                  child: Text(
                    'Explore More',
                    style: TextStyle(fontSize: 20),
                  ),
                  backgroundColor: Color.fromARGB(255, 111, 206, 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextSolution(BuildContext context) async {
    await _storeSelectedOptions();
    if (mood == 'Happy') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Happyhome()),
      );
    } else if (mood =='Neutral'){
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Neturalhome()),
      );
    }
    else 
    {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Sadhome()),
      ); 
    }
  }
  
 Future<void> _storeSelectedOptions() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    String? userId = auth.currentUser?.uid;

    await firestore.collection('user_answer').add({
      'userId': userId,
      'mood': mood,
      'totalMarks': totalMarks,
    });

    print('Selected options stored in Firestore');
  } catch (e) {
    print('Error storing selected options: $e');
  }
}
}
