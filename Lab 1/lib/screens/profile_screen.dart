import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/social_links.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Omkar Jadhav',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/omkar_jadhav.jpg'),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    'Omkar Jadhav',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  SocialLinks(),
                ],
              ),
            ),
            SizedBox(height: 24),
            buildSectionTitle('Profile Summary'),
            Text(
              'Software Developer | Flutter | MERN Stack | Passionate about trekking & technology.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            buildSectionTitle('Education'),
            buildEducationRow('HSC Maharashtra Board (March 2020)'),
            buildEducationRow('B.C.A. (Data Science)'),
            buildEducationRow('Master of Computer Applications (MCA)'),
            SizedBox(height: 24),
            buildSectionTitle('Skills'),
            buildSkillItem('• Programming: HTML, CSS, JavaScript, C++, Java, Python'),
            buildSkillItem('• Frameworks: React, Flutter, Node.js'),
            buildSkillItem('• Tools: Git, VS Code, IntelliJ, Android Studio'),
            SizedBox(height: 24),
            buildSectionTitle('Hobbies'),
            buildSkillItem('• Trekking'),
            buildSkillItem('• Playing Cricket'),
            buildSkillItem('• Watching Movies'),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }

  Widget buildEducationRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.school, color: Colors.blue),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildSkillItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}
