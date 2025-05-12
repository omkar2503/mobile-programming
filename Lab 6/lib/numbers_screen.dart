import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  final List<Map<String, String>> numbers = List.generate(
    20,
    (index) => {
      'number': (index + 1).toString(),
      'text': _numberToWord(index + 1),
    },
  );

  NumbersScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return Card(
          color: index % 2 == 0 ? Colors.teal[100] : Colors.orange[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numbers[index]['number']!,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                numbers[index]['text']!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        );
      },
    );
  }
}
