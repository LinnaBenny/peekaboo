import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentDashboardScreen extends StatelessWidget {
  final String parentUserId;
  final String parentEmail;

  ParentDashboardScreen({required this.parentUserId, required this.parentEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parental Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // StreamBuilder for parent details
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(parentUserId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print('Error fetching parent data: ${snapshot.error}');
                  return Center(child: Text('Error fetching data. Please try again later.'));
                }
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  print('No data available for user with ID: $parentUserId');
                  return Center(child: Text('No data available for this user.'));
                }

                var parentData = snapshot.data!.data() as Map<String, dynamic>;
                String parentName = parentData['name'] ?? 'Unknown';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Parent Name: $parentName'),
                    ),
                  ],
                );
              },
            ),
            // StreamBuilder for user_answer collection
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('user_answer').doc(parentUserId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print('Error fetching user_answer data: ${snapshot.error}');
                  return Center(child: Text('Error fetching data. Please try again later.'));
                }
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  print('No data available for user_answer with ID: $parentUserId');
                  return Center(child: Text('No data available for this user.'));
                }

                var userData = snapshot.data!.data() as Map<String, dynamic>;
                String mood = userData['mood'] ?? 'Unknown';
                int totalMarks = userData['totalMarks'] ?? 0;

                return Column(
                  children: [
                    ListTile(
                      title: Text('Mood: $mood'),
                    ),
                    ListTile(
                      title: Text('Total Marks: $totalMarks'),
                    ),
                  ],
                );
              },
            ),
            // StreamBuilder for child details
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').where('email', isEqualTo: parentEmail).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print('Error fetching child details: ${snapshot.error}');
                  return Center(child: Text('Error fetching child details. Please try again later.'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  print('No child details available for email: $parentEmail');
                  return Center(child: Text('No child details available.'));
                }

                QueryDocumentSnapshot childDoc = snapshot.data!.docs[0]; // Assuming only one child document
                Map<String, dynamic> childData = childDoc.data() as Map<String, dynamic>;
                String childName = childData['name'] ?? 'Unknown';
                int age = childData['age'] ?? 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text('Child Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text('Child Name: $childName'),
                      subtitle: Text('Age: $age'),
                    ),
                  ],
                );
              },
            ),
            // StreamBuilder for completed_task collection
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('completed_task').where('userId', isEqualTo: parentUserId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print('Error fetching completed tasks: ${snapshot.error}');
                  return Center(child: Text('Error fetching completed tasks. Please try again later.'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  print('No completed tasks available for user ID: $parentUserId');
                  return Center(child: Text('No completed tasks available.'));
                }

                List<Widget> completedTasksWidgets = snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> taskData = doc.data() as Map<String, dynamic>;
                  String taskName = taskData['name'] ?? 'Unknown';
                  Timestamp completedAtTimestamp = taskData['completed_at'] ?? Timestamp.now();
                  DateTime completedAt = completedAtTimestamp.toDate();
                  String completedAtFormatted = "${completedAt.toLocal()}".split(' ')[0];

                  return ListTile(
                    title: Text('Task: $taskName'),
                    subtitle: Text('Completed At: $completedAtFormatted'),
                  );
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text('Completed Tasks:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ...completedTasksWidgets,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
