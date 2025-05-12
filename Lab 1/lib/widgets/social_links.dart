import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => _launchURL('https://www.linkedin.com/in/omkar-jadhav'),
          child: Image.asset('assets/images/linkedin.png', height: 30, width: 30),
        ),
        GestureDetector(
          onTap: () => _launchURL('https://github.com/omkar-jadhav'),
          child: Image.asset('assets/images/git.png', height: 30, width: 30),
        ),
        GestureDetector(
          onTap: () => _launchURL('mailto:omkarjadhav2503@gmail.com'),
          child: Image.asset('assets/images/gmail.png', height: 30, width: 30),
        ),
        GestureDetector(
          onTap: () => _launchURL('tel:+917385649917'),
          child: Icon(Icons.phone, size: 30, color: Colors.black),
        ),
      ],
    );
  }
}
