import 'package:flutter/material.dart';
import 'package:master/homescreen.dart';
import 'package:master/question1.dart';
import './homescreen.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'image/homework.jpg', 
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 150),
                    Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                        color:Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            
                            Text(
                              '📝 Assessment Instructions:',
                              style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize:24,
                              ),
                            ),
                            SizedBox(height: 50),
                            Text('1. Answer each question honestly. Your feelings matter! ',style: TextStyle(
                                color:Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize:18,
                              ),),
                            Text('2. Be like a superhero and focus your superpowers on answering these questions. No capes required!',style: TextStyle(
                                color:Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize:18,
                              ),),
                            Text('3. Remember, this quiz is like a friendly chat with a wise owl, not a test you can fail. So, relax and enjoy the ride!'
                            ,style: TextStyle(
                                color:Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize:18,
                              ),),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                               
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Questions()),
                                );
                              },
                              child: Text('START NOW'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black38
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
