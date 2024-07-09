import 'package:flutter/material.dart';

class StorybookScreen extends StatefulWidget {
  @override
  _StorybookScreenState createState() => _StorybookScreenState();
}

class _StorybookScreenState extends State<StorybookScreen> {
  String currentScene = 'scene1';

  Map<String, Map<String, dynamic>>? storyScenes = {
    'scene1': {
      'text': 'Once upon a time, in a magical forest, a friendly rabbit named Benny encountered a mysterious creature. What should Benny do?',
      'choices': {
        'Choice 1': 'scene2a',
        'Choice 2': 'scene2b',
      },
    },
    'scene2a': {
      'text': 'Benny approached the creature cautiously and greeted it with a smile. The creature responded with a friendly gesture. Benny felt happy and curious. What should Benny do next?',
      'choices': {
        'Choice A': 'scene3a',
        'Choice B': 'scene3b',
      },
    },
    'scene2b': {
      'text': 'Benny ran away in fear from the mysterious creature. As he fled, he stumbled upon a hidden path. What should Benny do?',
      'choices': {
        'Choice X': 'scene3c',
        'Choice Y': 'scene3d',
      },
    },
    'scene3a': {
      'text': 'Benny decided to explore further with the creature. Together, they discovered a magical waterfall. Benny felt excited and adventurous. The end.',
      'choices': {},
    },
    'scene3b': {
      'text': 'Benny decided to play it safe and return home. As he left, he felt relieved but also a little disappointed. The end.',
      'choices': {},
    },
    'scene3c': {
      'text': 'Benny followed the hidden path and found a beautiful garden filled with colorful flowers. He felt calm and peaceful. The end.',
      'choices': {},
    },
    'scene3d': {
      'text': 'Benny continued running until he reached a familiar place. He realized he had been here before and felt safe. The end.',
      'choices': {},
    },
  };

  void goToScene(String sceneId) {
    setState(() {
      currentScene = sceneId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Storybook'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Display current scene text
            Text(
              storyScenes?[currentScene]?['text'] ?? '',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            // Display choices for the current scene
            if (storyScenes?[currentScene]?['choices'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: (storyScenes?[currentScene]?['choices'] as Map<String, dynamic>).keys.map((choice) {
                  return ElevatedButton(
                    onPressed: () {
                      goToScene((storyScenes?[currentScene]?['choices'] as Map<String, dynamic>)[choice]);
                    },
                    child: Text(choice),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StorybookScreen(),
  ));
}
