import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class NeutralExercise extends StatefulWidget {
  @override
  _ExerciseNeutralState createState() => _ExerciseNeutralState();
}

class _ExerciseNeutralState extends State<NeutralExercise> {
  Map<String, bool> isCheckedMap = {};
  int selectedCount = 0;
  bool isSelectionLocked = false;
  bool isTimerStarted = false;
  late Timer _timer;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    generateRandomExercise();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    _timer.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  void generateRandomExercise() {
    List<String> exercise = ['Child Pose', 'Cat Cow Pose', 'Seated Forward Bend Pose','Mountain Pose', ];
    exercise.shuffle();
    isCheckedMap = {
      exercise[0]: false,
      exercise[1]: false,
      exercise[2]: false,
    };
  }

  void startTimer() {
    _timer = Timer(Duration(minutes: 1), () {
      setState(() {
        isSelectionLocked = true;
        _confettiController.play();
      });
    });
    setState(() {
      isTimerStarted = true;
    });
  }

  bool isTimerFinished() {
    return !isTimerStarted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/grey.jpeg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: isTimerStarted ? null : () {
                  startTimer();
                },
                child: Text('Start Activities'),
              ),
              if (isTimerStarted)
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "Let's try some exercises.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    SlideCountdown(
                      duration: Duration(minutes: 1),
                      separatorType: SeparatorType.title,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.access_time_sharp,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      onDone: () {
                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            isTimerStarted = false;
                            isSelectionLocked = false; 
                          });
                        });
                        // Handle timer completion if needed
                      },
                      slideDirection: SlideDirection.down,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    buildExercise(),
                    SizedBox(height: 30),
                  ElevatedButton(
                  onPressed: isTimerStarted ? null : () {
                    setState(() {
                      isSelectionLocked = true;
                      _confettiController.play();
                    });
                  },
                  child: Text('Submit'),
                ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirection: -pi / 2,
                        emissionFrequency: 0.2,
                        numberOfParticles: 20,
                        blastDirectionality: BlastDirectionality.directional,
                        gravity: 0.1,
                        colors: const [
                          Colors.blueAccent,
                          Colors.pinkAccent,
                          Colors.purpleAccent,
                          Colors.greenAccent
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (isSelectionLocked)
                      Text(
                        'Congratulations! You completed the task successfully!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExercise() {
    return Column(
      children: isCheckedMap.keys
          .map((exercise) => buildExerciseWithCheckbox(exercise))
          .toList(),
    );
  }

  Widget buildExerciseWithCheckbox(String name) {
    String imagePath = 'image/${name.toLowerCase()}.jpeg';
    return Row(
      children: [
        Checkbox(
          value: isCheckedMap[name]!,
          onChanged: isSelectionLocked
              ? null
              : (bool? value) {
            setState(() {
              if (value!) {
                if (selectedCount < 3) {
                  isCheckedMap[name] = value;
                  selectedCount++;
                }
              } else {
                isCheckedMap[name] = value;
                selectedCount--;
              }
            });
          },
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.brown,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(width: 12),
        SizedBox(
          height: 250,
          width: 250,
          child: Image.asset(imagePath),
        ),
      ],
    );
  }
}
