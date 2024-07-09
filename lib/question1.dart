import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master/question2.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  Map<String, int?> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/grey.jpeg'), 
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
                        color: Colors.brown,
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  Image.asset('image/logo.png'),
                ],
              ),
              SizedBox(height: 20),
              _buildQuestion('1. How are you feeling today?', {
                'Happy 😀': 10,
                'Neutral 😐': 6,
                'Sad 😔': 4,
              }),
              _buildQuestion('2. How do you feel about going to school today?', {
                'Happy 😀': 10,
                'Neutral 😐': 6,
                'Sad 😔': 4,
              }),
              _buildQuestion('3. How are you feel when you think about spending time with your friend?', {
                'Happy 😀': 10,
                'Neutral 😐': 6,
                'Sad 😔': 4,
              }),
              _buildQuestion('4. How do you feel when you play outdoors compared to indoors?', {
                'Happy 😀': 10,
                'Neutral 😐': 6,
                'Sad 😔': 4,
              }),
              _buildQuestion('5. How do you feel when you spend time with your family?', {
                'Happy 😀': 10,
                'Neutral 😐': 6,
                'Sad 😔': 4,
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveUserResponsesToFirestore(selectedOptions);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage(selectedOptions: selectedOptions)),
          );
        },
        child: Text('Next', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
      ),
    );
  }

  Widget _buildQuestion(String question, Map<String, int> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            question,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: options.entries.map((MapEntry<String, int> entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOptions[question] = entry.value;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return entry.value == selectedOptions[question] ? Color.fromARGB(255, 160, 209, 249) : Colors.white;
                  }),
                  foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 3, 3, 3)),
                ),
                child: Text(
                  entry.key,
                  style: TextStyle(fontFamily: 'NotoColorEmoji', fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _saveUserResponsesToFirestore(Map<String, int?> responses) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String userId = 'user_id_here';
      responses.forEach((question, value) {
        firestore.collection('user_responses').add({
          'userId': userId,
          'question': question,
          'value': value,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      print('User responses saved to Firestore');
    } catch (e) {
      print('Error saving user responses: $e');
    }
  }
}
