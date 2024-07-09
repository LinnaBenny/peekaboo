import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class OrigamiHappy extends StatefulWidget {
  @override
  _OrigamiHappyState createState() => _OrigamiHappyState();
}

class _OrigamiHappyState extends State<OrigamiHappy> {
  Map<String, bool> isCheckedMap = {};
  int selectedCount = 0;
  bool isSelectionLocked = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    generateRandomOrigamis();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose the confetti controller
    super.dispose();
  }

  void generateRandomOrigamis() {
    List<String> origamis = ['Dog', 'Cat', 'Rabbit', 'Tulip', 'Panda', 'Butterfly', 'Squirrel'];
    origamis.shuffle();
    isCheckedMap = {
      origamis[0]: false,
      origamis[1]: false,
      origamis[2]: false,
    };
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 12),
                Text(
                  'Welcome to Origami Fun',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Let's try some origami activities. Here we are providing some work. Try to work on it",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                buildOrigamis(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: selectedCount == 3
                      ? () {
                          setState(() {
                            isSelectionLocked = true;
                            _confettiController.play();
                          });
                        }
                      : null,
                  child: Text('Submit'),
                ),
                Align(
                  alignment:Alignment.bottomCenter ,
                  child:ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: -pi /2,
                    emissionFrequency: 0.2,
                    numberOfParticles: 20,
                    blastDirectionality: BlastDirectionality.directional,
                    gravity: 0.1,
                    colors: const[
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
                      color: Colors.brown,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrigamiWithCheckbox(String name) {
    String imagePath = 'image/${name.toLowerCase()}origami.jpg';
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
          ),
        ),
        SizedBox(width: 12),
        SizedBox(
          height: 500,
          width: 475,
          child: Image.asset(imagePath),
        ),
      ],
    );
  }

  Widget buildOrigamis() {
    return Column(
      children: isCheckedMap.keys
          .map((origami) => buildOrigamiWithCheckbox(origami))
          .toList(),
    );
  }
}
