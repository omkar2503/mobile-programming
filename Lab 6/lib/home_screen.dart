import 'package:flutter/material.dart';
import 'practice_screen.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}); // Removed const

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("LearnPlay Hub",
              style: TextStyle(fontWeight: FontWeight.bold,)),
              centerTitle: true, // Explicitly centers the title
          elevation: 4,
          bottom: const TabBar(
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Practice", icon: Icon(Icons.book)),
              Tab(text: "Quiz", icon: Icon(Icons.quiz)),
              Tab(text: "Leaderboard", icon: Icon(Icons.leaderboard)),
              Tab(text: "Profile", icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          // Removed const
          children: [
            PracticeScreen(),
            QuizScreen(),
            LeaderboardScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
