import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master/results.dart';

class SecondPage extends StatefulWidget {
  final Map<String, int?> selectedOptions;

  const SecondPage({Key? key, required this.selectedOptions}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Map<String, int?> allSelectedOptions;

  @override
  void initState() {
    super.initState();
    allSelectedOptions = Map.from(widget.selectedOptions);
  }

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
              _buildQuestion(
                  '6. How do you feel about trying new activities or sports? ', ['Happy 😀', 'Neutral 😐', 'Sad 😔']),
              _buildQuestion('7. When something does not go as planned, how do you typically feel',
                  ['Happy 😀', 'Neutral 😐', 'Sad 😔']),
              _buildQuestion(
                  '8. How do you feel about talking to someone new, like a new teacher or classmate?',
                  ['Happy 😀', 'Neutral 😐', 'Sad 😔']),
              _buildQuestion(
                  '9. When you accomplish something you have been working hard on, how does it make you feel? ',
                  ['Happy 😀', 'Neutral 😐', 'Sad 😔']),
              _buildQuestion('10. How do you feel about trying new foods or eating meals?',
                  ['Happy 😀', 'Neutral 😐', 'Sad 😔']),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () => submitAnswers(context),
            child: Text(
              'Submit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 176, 218, 253),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(String question, List<String> options) {
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
          children: options.map((String option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  int? selectedValue = _getOptionValue(option);
                  if (selectedValue != null) {
                    setState(() {
                      allSelectedOptions[question] = selectedValue;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return _getOptionValue(option) == allSelectedOptions[question] ? Color.fromARGB(255, 160, 209, 249) : Colors.white;
                  }),
                  foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 3, 3, 3)),
                ),
                child: Text(
                  option,
                  style: TextStyle(fontFamily: 'NotoColorEmoji',
                  fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  int? _getOptionValue(String option) {
    switch (option) {
      case 'Happy 😀':
        return 10;
      case 'Neutral 😐':
        return 6;
      case 'Sad 😔':
        return 4;
      default:
        return null;
    }
  }

  void submitAnswers(BuildContext context) async {
  await _storeSelectedOptions();
  int totalMarks = _calculateTotalMarks();
  print('Total Marks: $totalMarks'); 
  String mood = _determineMood(totalMarks);
  print('Mood: $mood'); 

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ResultPages(mood, totalMarks)),
  );
}


  int _calculateTotalMarks() {
    int totalMarks = 0;
    allSelectedOptions.values.forEach((value) {
      if (value != null) {
        totalMarks += value;
      }
    });
    return totalMarks;
  }

  String _determineMood(int totalMarks) {
    if (totalMarks >= 75 && totalMarks <= 100) {
      return 'Happy';
    } else if (totalMarks >= 40 && totalMarks <= 75) {
      return 'Neutral';
    } else {
      return 'Sad';
    }
  }

  Future<void> _storeSelectedOptions() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      allSelectedOptions.forEach((question, value) {
        firestore.collection('user_responses').add({
          'question': question,
          'value': value,
        });
      });
      print('Selected options stored in Firestore');
    } catch (e) {
      print('Error storing selected options: $e');
    }
  }
}
