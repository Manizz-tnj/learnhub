import 'package:flutter/material.dart';

class EnglishCourse extends StatelessWidget {
  const EnglishCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('English Course')),
      body: const Center(child: Text('Welcome to English Course')),
    );
  }
}
