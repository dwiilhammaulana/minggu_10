import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.amber)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(height: 300,width: double.infinity,color: Colors.purple),
          ),
          
        ],
      ),
      bottomNavigationBar: Container(height: 80, color: Colors.blue,),
    );
  }
}
