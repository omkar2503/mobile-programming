import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;
  StudentDetailsScreen({required this.studentData});

  // Function to calculate average CGPA
  double calculateAverageCGPA() {
    double sum = 0;
    int count = 0;

    for (int i = 1; i <= 5; i++) {
      if (studentData['sem$i'] != null) {
        sum += studentData['sem$i'];
        count++;
      }
    }

    return count > 0 ? sum / count : 0;
  }

  @override
  Widget build(BuildContext context) {
    double averageCGPA = calculateAverageCGPA();

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildDetailItem('Name', studentData['name']),
              _buildDetailItem('Email', studentData['email']),
              _buildDetailItem('Contact', studentData['contact']),
              _buildDetailItem('Roll No', studentData['rollNo']),
              _buildDetailItem('HSC Percentage', studentData['hscPercentage']?.toStringAsFixed(2)),
              _buildDetailItem('SSC Percentage', studentData['sscPercentage']?.toStringAsFixed(2)),
              _buildDetailItem('Marks in Sem 1', studentData['sem1']),
              _buildDetailItem('Marks in Sem 2', studentData['sem2']),
              _buildDetailItem('Marks in Sem 3', studentData['sem3']),
              _buildDetailItem('Marks in Sem 4', studentData['sem4']),
              _buildDetailItem('Marks in Sem 5', studentData['sem5']),
              _buildDetailItem('CGPA Till 5th Sem', averageCGPA.toStringAsFixed(2)), // Display average CGPA
              _buildDetailItem('Additional Courses', studentData['courses']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value?.toString() ?? "N/A",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}