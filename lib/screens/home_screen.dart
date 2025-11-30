import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Selamat datang di aplikasi!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}




