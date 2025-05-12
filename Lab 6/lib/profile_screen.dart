import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Omkar';
  int stars = 0;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Omkar';
      stars = (prefs.getInt('latestScore_$userName') ?? 0) ~/
          2; // 1 star per 2 points
      _nameController.text = userName;
    });
  }

  Future<void> _saveName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    int oldScore = prefs.getInt('latestScore_$userName') ?? 0;
    await prefs.setString('userName', newName);
    await prefs.setInt('latestScore_$newName', oldScore); // Transfer score
    setState(() {
      userName = newName;
      stars = oldScore ~/ 2;
    });
    Navigator.pop(context);
  }

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: "Enter your name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => _saveName(_nameController.text.trim()),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.teal,
            child: Icon(Icons.person, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            userName,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 10),
          const Text(
            "Level: Beginner",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                stars,
                (index) => const Icon(Icons.star,
                    color: Colors.orangeAccent, size: 30)),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showEditNameDialog,
            child: const Text("Edit Name", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
