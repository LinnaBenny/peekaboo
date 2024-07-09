import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kid\'s Joy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Aboutus(),
    );
  }
}

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  bool _showInfo1 = false;
  bool _showInfo2 = false;

  void _toggleInfo1() {
    setState(() {
      _showInfo1 = !_showInfo1;
      if (_showInfo1) {
        _showInfo2 = false;
      }
    });
  }

  void _toggleInfo2() {
    setState(() {
      _showInfo2 = !_showInfo2;
      if (_showInfo2) {
        _showInfo1 = false; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/PEEKABOOabout.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
           Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'PEEKABOO',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(175.0),
                    child: const Text(
                      """Welcome to Peekaboo, the ultimate playground for children aged 5-12! We’re all about combining fun, learning, and emotional well-being in one vibrant, engaging platform. Here at Kid's Joy, every click leads to a new adventure, and every activity brings a smile to your child's face.""",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StarShape(
                        label: '5-7',
                        color: Color.fromARGB(213, 177, 219, 254),
                        size: 200,
                        hiddenInfo: """For Ages 5-8:
- Puzzle Games: Exciting puzzles that challenge the brain and spark problem-solving magic.
- Drawing Board: A virtual canvas for unleashing creativity.
- Mood Game: A fun way for little ones to express their feelings.""",
                        onTap: _toggleInfo1,
                        showInfo: _showInfo1,
                      ),
                      const SizedBox(width: 40),
                      StarShape(
                        label: '8-12',
                        color: Color.fromARGB(135, 246, 184, 233),
                        size: 200,
                        hiddenInfo: """For Ages 8-12:
- Mood Assessment: A fun 10-question quiz to understand your child's mood.
- Personalized Activities: Tailored suggestions like:
  - Origami Fun: Creative paper folding projects.
  - Kindness Challenges: Heartwarming tasks to spread joy.
  - Exciting Exercises: Fun activities to stay active.""",
                        onTap: _toggleInfo2,
                        showInfo: _showInfo2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_showInfo1 || _showInfo2)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white.withOpacity(0.8),
                      child: Text(
                        _showInfo1
                            ? """For Ages 5-8:
- Puzzle Games: Exciting puzzles that challenge the brain and spark problem-solving magic.
- Drawing Board: A virtual canvas for unleashing creativity.
- Mood Game: A fun way for little ones to express their feelings."""
                            : """For Ages 8-12:
- Mood Assessment: A fun 10-question quiz to understand your child's mood.
- Personalized Activities: Tailored suggestions like:
  - Origami Fun: Creative paper folding projects.
  - Kindness Challenges: Heartwarming tasks to spread joy.
  - Exciting Exercises: Fun activities to stay active.""",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parental Monitoring',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          """We understand the importance of parental involvement in a child's development. That's why we've included a Parental Login feature, allowing parents to:\n
- Monitor their child's mental health and emotional well-being.\n
- View assessment results and recommended activities.\n
- Track their child's progress and engagement with the web app.""",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Mission',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          """At Peekaboo, we believe in nurturing the whole child - mind, body, and spirit. Our platform is designed to be a supportive tool that not only entertains but also educates and empowers children to express their emotions, develop new skills, and grow in a healthy, balanced way.\n
Join us on this joyful journey and let's make learning and emotional well-being fun for every child!\n""",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'For any questions or support, please contact us at support@peekaboo.com.\n\nPeekaboo - Where Learning and Happiness Meet!',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: Text(
                  '© 2024 Peekaboo. All rights reserved.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarShape extends StatelessWidget {
  final String label;
  final Color color;
  final double size;
  final String hiddenInfo;
  final VoidCallback onTap;
  final bool showInfo;

  const StarShape({
    required this.label,
    required this.color,
    required this.size,
    required this.hiddenInfo,
    required this.onTap,
    required this.showInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: showInfo ? color.withOpacity(0.5) : color,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
