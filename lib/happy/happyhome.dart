import 'package:flutter/material.dart';
import 'package:master/happy/happypage.dart';
class Happyhome extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Happyhome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double>? _animation;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward(); 
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/grey.jpeg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: FadeTransition(
          opacity: _animation!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
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
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  Image.asset('image/logo.png'),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: ScaleTransition(
                  scale: _animation!,
                  child: Container(
                    height: 225,
                    width: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'It\'s great to see you\'re feeling happy today! 😊 Your positive energy is contagious, and we\'re thrilled to have you here with us. Now that we\'ve checked your mood and confirmed your happiness, let\'s explore some activities you can dive into to make the most out of this wonderful mood!',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ), 
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HappyPage()),
                              );
                            },
                            child: Text('Continue'), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
