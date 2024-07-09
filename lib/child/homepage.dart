import 'package:flutter/material.dart';
import 'package:master/child/feelingstracker.dart';
import 'package:master/happy/happyhub.dart';
import 'package:master/child/puzzle.dart';
import 'package:master/child/drawinggame.dart';

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
      height: 45,
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

class ChildHome extends StatelessWidget {
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
            image: AssetImage('image/childpic.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 275),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 15),
                SelectOptionButton(
                  text: 'Puzzle Game',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PuzzleGame()));
                  },
                ),
                SizedBox(height: 20),
                SelectOptionButton(
                  text: 'Feelings Tracker',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeelingsBingoApp())); 
                  },
                ),
                SizedBox(height: 20),
                SelectOptionButton(
                  text: 'PencilPlayground',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArtCanvas())); 
                  },
                ),
                SizedBox(height: 20),
               /* SelectOptionButton(
                  text: 'Happy Hub',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoEx()));
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
