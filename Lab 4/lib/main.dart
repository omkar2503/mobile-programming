import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/view_resume_screen.dart';
import 'screens/company_details_screen.dart';
import 'screens/student_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> studentData = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(
        updateStudentData: (data) {
          setState(() {
            studentData = data;
          });
        },
        studentData: studentData,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(Map<String, dynamic>) updateStudentData;
  final Map<String, dynamic> studentData;

  MyHomePage({required this.updateStudentData, required this.studentData});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(), // Home screen as the first option
      RegisterScreen(updateStudentData: widget.updateStudentData),
      ViewResumeScreen(resumeFilePath: widget.studentData['resumePath']),
      CompanyDetailsScreen(),
      StudentDetailsScreen(studentData: widget.studentData),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('TPO App'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/college_logo.png', height: 80),
                  SizedBox(height: 10),
                  Text(
                    'S.P.I.T',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              title: Text('Register'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            ListTile(
              title: Text('View Resume'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 2);
              },
            ),
            ListTile(
              title: Text('Company Details'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 3);
              },
            ),
            ListTile(
              title: Text('Student Details'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 4);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}