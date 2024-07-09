import 'package:flutter/material.dart';

class KindnessChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Kindnessaction(),
    );
  }
}

class Kindnessaction extends StatefulWidget {
  @override
  _KindnessJarScreenState createState() => _KindnessJarScreenState();
}

class _KindnessJarScreenState extends State<Kindnessaction> {
  List<String> kindnessActivities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindness Action'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'image/jarimage.png',
                  height: 400,
                  width: 700,
                ), 
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: kindnessActivities
                          .map((activity) => Draggable<String>(
                                data: activity,
                                child: KindnessActivity(activity),
                                feedback: Material(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(activity),
                                  ),
                                ),
                                childWhenDragging: Container(),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Drag and drop kindness activities that you have done today into the jar. Click on the + symbol to add your content into the jar.\n Example: Including Others,Helping parents,Comforting a Friend,Volunteering,Apologizing and Forgiving,Being a Good Listener,Write a thank you note',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddActivityDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    String newActivity = '';
    if (kindnessActivities.length >= 6) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kindness Jar Full'),
            content: Text('You have already added six kindness activities!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Kindness Activity'),
          content: TextField(
            onChanged: (value) {
              newActivity = value;
            },
            decoration: InputDecoration(hintText: 'Enter your activity'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (newActivity.isNotEmpty) {
                  setState(() {
                    kindnessActivities.add(newActivity);
                  });
                  if (kindnessActivities.length >= 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You have filled the kindness jar! Great job!'),
                      ),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class KindnessActivity extends StatelessWidget {
  final String activity;

  KindnessActivity(this.activity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          activity,
          style: TextStyle(color: Colors.brown,
          fontWeight: FontWeight.w700 ),
        ),
      ),
    );
  }
}
