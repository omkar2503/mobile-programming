import 'package:flutter/material.dart';

class AlphabetsScreen extends StatelessWidget {
  final List<Map<String, String>> alphabets = List.generate(
    26,
    (index) => {
      'upper': String.fromCharCode(65 + index), // A-Z
      'lower': String.fromCharCode(97 + index), // a-z
    },
  );

  AlphabetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1, // Keeps the box size as is
      ),
      itemCount: alphabets.length,
      itemBuilder: (context, index) {
        return Card(
          color: index % 2 == 0 ? Colors.teal[100] : Colors.orange[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  alphabets[index]['upper']!,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(width: 5), // Small gap between upper and lower
                Text(
                  alphabets[index]['lower']!,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
