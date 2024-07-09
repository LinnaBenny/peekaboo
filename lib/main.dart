import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:master/happy/origamifun.dart';
import 'package:master/netural/neturalpage.dart';
import 'package:master/sad/sadkindness.dart';
import './login.dart'; 
import './loginparent.dart';
import './homescreen.dart';
import './assessment.dart';
import './question1.dart';
import './question2.dart';
import './sign_up_page.dart';
import './age.dart';
import './aboutus.dart';
import 'package:master/happy/happyhome.dart';
import 'package:master/happy/happypage.dart';
import 'package:master/happy/origamifun.dart';
import 'package:master/happy/kindnesshappy.dart';
import 'package:master/netural/neturalhome.dart';
import 'package:master/netural/neturalpage.dart';
import 'package:master/netural/neuralorigami.dart';
import 'package:master/sad/sadhome.dart';
import 'package:master/sad/Sadpage.dart';
import 'package:master/sad/sadorigami.dart';
import 'package:master/happy/happyfeelgood.dart';
import 'package:master/netural/neutralfeelgood.dart';
import 'package:master/sad/sadfeelgood.dart';
import 'package:master/happy/happyhub.dart';
import 'package:master/sad/sadfeelgood.dart';
import 'package:master/netural/neutralkindness.dart';
import 'package:master/child/homepage.dart';
import 'package:master/child/puzzle.dart';
import 'package:master/child/drawinggame.dart';
import 'package:master/child/feelingstracker.dart';
import 'package:master/netural/storywriting.dart';
import 'package:master/parental/dashboard.dart';
import 'package:master/parentsignup.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:FirebaseOptions(
      apiKey: "AIzaSyCEUqFb4EgfYlXfNK6frEcCrl_lRoqFsoo",
      projectId: "peekaboo2-85182",
       messagingSenderId: "412738583152",
       appId:"1:412738583152:web:27fcca4e8642704df2d2b5",
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    
      routes: {
         '/login': (context) => LoginPage(),
        '/loginparent': (context) => LoginPageParent(),
        '/aboutus':(context) => Aboutus(),
        '/assessment':(context)=> AssessmentPage(),
        '/question1':(context)=> Questions(),
        '/question2':(context) => SecondPage(selectedOptions: {},),
        '/sign_up_page':(context) => SignupPage(),
        '/age':(context) => AgeSelectionPage(),
        '/Happyhome':(context) => Happyhome(),
        '/Happypage':(context) => HappyPage(),
        '/OrigamiHappy':(context) => OrigamiHappy(),
        '/Neutralhome':(context) => Neturalhome(),
        '/NeutralPage':(context) => NeturalPage(),
        '/OrigamNeutral':(context) => OrigamiNeutral(),
         '/SadHome':(context) => Sadhome(),
         '/SadPage':(context) => SadPage(),
         '/SadOrigami':(context) => OrigamiSad(),
         '/kindnesshappy':(context) => KindnessJarScreen(),
         '/happyfeelgood':(context) => HappyExercise(),
         '/neutralfeelgood':(context)=>NeutralExercise(),
         '/sadfeelgood':(context) => SadExercise(),
          '/sadkindness':(context) => Kindnessaction(),
          '/neutralkindness':(context) => KindnessJarActivity(),
          '/happyhub':(context) => VideoEx(),
          '/childpage':(context) => ChildHome(),
          '/childpuzzle':(context) => PuzzleGame(),
          '/drawinggame':(context) => ArtCanvas(),
          '/feelingstracker':(context) => FeelingsBingoApp(),
          '/storywriting':(context) => ImageStoryWriterPage(),
        '/dashboard': (context) => ParentDashboardScreen(parentUserId: 'parent_user_id_here', parentEmail: 'parent_email_here'),
        '/parentregister':(context) => RegisterPageParent()
      },
    );
  }
}
