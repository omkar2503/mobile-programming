import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Map<String, dynamic>> quizData;
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    quizData = _generateQuizData();
    _shuffleQuizData();
  }

  static String _numberToWord(int number) {
    const List<String> words = [
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Eleven',
      'Twelve',
      'Thirteen',
      'Fourteen',
      'Fifteen',
      'Sixteen',
      'Seventeen',
      'Eighteen',
      'Nineteen',
      'Twenty'
    ];
    return words[number - 1];
  }

  List<Map<String, dynamic>> _generateQuizData() {
    return [
      ...List.generate(
          20,
          (index) => {
                'type': 'number',
                'question': (index + 1).toString(),
                'display': _numberToWord(index + 1),
                'options': [
                  _numberToWord(index + 1),
                  _numberToWord((index + 2) % 20 + 1),
                  _numberToWord((index + 3) % 20 + 1)
                ],
                'answer': _numberToWord(index + 1),
              }),
      ...List.generate(
          26,
          (index) => {
                'type': 'alphabet',
                'question': String.fromCharCode(65 + index),
                'display': String.fromCharCode(65 + index),
                'options': [
                  String.fromCharCode(65 + index),
                  String.fromCharCode(65 + (index + 1) % 26),
                  String.fromCharCode(65 + (index + 2) % 26)
                ],
                'answer': String.fromCharCode(65 + index),
              }),
    ];
  }

  void _shuffleQuizData() {
    quizData.shuffle(Random());
    for (var question in quizData) {
      question['options'].shuffle(Random()); // Jumble options for each question
    }
  }

  void checkAnswer(String selectedOption) async {
    if (selectedOption == quizData[currentQuestionIndex]['answer']) {
      score++;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Correct!"),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 300), // Reduced from default 4s
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong!"),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 300), // Reduced from default 4s
        ),
      );
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      // Match snackbar duration
      setState(() {
        if (currentQuestionIndex < 9) {
          currentQuestionIndex++;
        } else {
          _saveScore();
          _showResultDialog();
        }
      });
    });
  }

  void _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('userName') ?? 'Saumya';
    await prefs.setInt('latestScore_$name', score);
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Text("Your score: $score/10"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                _shuffleQuizData();
              });
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizData[currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / 10,
            color: Colors.teal,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            "Question ${currentQuestionIndex + 1}/10",
            style: const TextStyle(
                fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            currentQuestion['question'],
            style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 20),
          const Text(
            "What is this?",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Column(
            children: currentQuestion['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                  ),
                  child: Text(option, style: const TextStyle(fontSize: 18)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
