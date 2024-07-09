import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PuzzleGame(), 
  ));
}

class PuzzleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/macro.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: PuzzleScreen(),
      ),
    );
  }
}

class PuzzleScreen extends StatefulWidget {
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<int> numbers = [];
  final int rows = 3;
  final int columns = 3;
  double blockSize = 0;
  int emptyIndex = 0;
  int moves = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      do {
        numbers = List.generate(rows * columns - 1, (index) => index + 1)..shuffle(); 
        numbers.add(0);
        blockSize = (300 / columns).floorToDouble();
        emptyIndex = numbers.indexOf(0);
      } while (!isSolvable());
      moves = 0; 
    });
  }

  bool isSolvable() {
    int inversions = 0;
    for (int i = 0; i < rows * columns - 1; i++) {
      for (int j = i + 1; j < rows * columns; j++) {
        if (numbers[i] > numbers[j] && numbers[j] != 0) {
          inversions++;
        }
      }
    }
    // If the grid width is odd, the number of inversions should be even for the puzzle to be solvable
    if (columns % 2 == 1) {
      return inversions % 2 == 0;
    }
    // If the grid width is even, the sum of the row number of the empty tile and the number of inversions should be odd
    return (emptyIndex ~/ columns + 1 + inversions) % 2 == 1;
  }

  bool isSolved() {
    return List.generate(rows * columns, (index) => index).every((i) => numbers[i] == i + 1);
  }

  void moveTile(int tappedIndex) {
    setState(() {
      
      if ((emptyIndex - columns == tappedIndex && emptyIndex >= columns) ||
          (emptyIndex + columns == tappedIndex && emptyIndex < rows * columns - columns) || 
          (emptyIndex - 1 == tappedIndex && emptyIndex % columns != 0) ||
          (emptyIndex + 1 == tappedIndex && (emptyIndex + 1) % columns != 0)) {
        int temp = numbers[tappedIndex];
        numbers[tappedIndex] = numbers[emptyIndex];
        numbers[emptyIndex] = temp;
        emptyIndex = tappedIndex;
        moves++; 
        if (isSolved()) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Congratulations!'),
              content: Text('You solved the puzzle in $moves moves!'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: 1.0, 
                  ),
                  itemCount: rows * columns,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (numbers[index] != 0) {
                          moveTile(index);
                        }
                      },
                      child: Container(
                        color: numbers[index] == 0 ? Colors.grey : const Color.fromARGB(255, 73, 169, 248),
                        margin: EdgeInsets.all(2),
                        alignment: Alignment.center,
                        child: Text(
                          numbers[index] == 0 ? '' : '${numbers[index]}',
                          style: TextStyle(color: Colors.white, fontSize: blockSize * 0.4),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Reset Game'),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Moves: $moves',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
