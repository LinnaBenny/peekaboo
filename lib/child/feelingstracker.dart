import 'package:flutter/material.dart';

void main() {
  runApp(FeelingsBingoApp());
}

class FeelingsBingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feelings Bingo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeelingsBingoScreen(),
    );
  }
}

class FeelingsBingoScreen extends StatefulWidget {
  @override
  _FeelingsBingoScreenState createState() => _FeelingsBingoScreenState();
}

class _FeelingsBingoScreenState extends State<FeelingsBingoScreen> {
  List<String> iconsList = [
    '😊', // Happy
    '😢', // Sad
    '😄', // Excited
    '😡', // Angry
    '😨', // Scared
    '😴', // Tired
    '😜', // Silly
    '😇', // Proud
    '❤️', // Loved
    '😕', // Confused
  ];

  List<String> selectedIcons = [];
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    generateBingoItems();
  }

  void generateBingoItems() {
    iconsList.shuffle();
    selectedIcons = [];
  }

  void resetGame() {
    setState(() {
      gameOver = false;
      generateBingoItems();
    });
  }

  void checkBingo() {
    if (selectedIcons.length == 3) {
      setState(() {
        gameOver = true;
      });
    }
  }

  Map<String, int> emotionScores = {
    '😊': 10, // Happy
    '😢': 4, // Sad
    '😄': 9, // Excited
    '😡': 4, // Angry
    '😨': 3, // Scared
    '😴': 3, // Tired
    '😜': 8, // Silly
    '😇': 10, // Proud
    '❤️': 10, // Loved
    '😕': 5, // Confused
  };

  double calculateAverageMood() {
    double totalScore = 0;
    for (var icon in selectedIcons) {
      if (emotionScores.containsKey(icon)) {
        totalScore += emotionScores[icon]!;
      }
    }
    return totalScore / selectedIcons.length;
  }

  String evaluateMood() {
    double averageScore = calculateAverageMood();
    if (averageScore >= 7) {
      return 'Happy';
    } else if (averageScore >= 4) {
      return 'Neutral';
    } else {
      return 'Sad';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feelings Bingo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select 3 feelings you have experienced recently:',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            gameOver
                ? Column(
                    children: [
                      Text(
                        'Your mood:',
                        style: TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        evaluateMood(),
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Average Mood Score: ${calculateAverageMood().toStringAsFixed(1)}/10',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: resetGame,
                        child: Text('Play Again'),
                      ),
                    ],
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    children: iconsList.map((icon) {
                      return GestureDetector(
                        onTap: () {
                          if (!selectedIcons.contains(icon)) {
                            setState(() {
                              selectedIcons.add(icon);
                              checkBingo();
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedIcons.contains(icon)
                                  ? Colors.green
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            icon,
                            style: TextStyle(fontSize: 50.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
