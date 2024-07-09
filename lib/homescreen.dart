import 'package:flutter/material.dart';
import 'package:master/aboutus.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 350),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(
                  title: 'About Us',
                  onTap: () {
                    Navigator.pushNamed(context, '/aboutus');
                  },
                ),
                _buildMenuButton(
                  title: 'Register',
                  onTap: () {
                    Navigator.pushNamed(context,'/sign_up_page' );
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(
                  title: 'Child Login',
                  onTap: () {
                    Navigator.pushNamed(context,'/login');
                  },
                ),
                _buildMenuButton(
                  title: 'Parental Login',
                  onTap: () {
                    Navigator.pushNamed(context, '/loginparent');
                  },
                ),
              ],
            ),
            SizedBox(height: 24), 
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 51,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.brown,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
