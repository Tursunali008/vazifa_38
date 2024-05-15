import 'package:flutter/material.dart';
import 'package:vazifa_38/screens/main_screen.dart';

void main(List<String> args) {
  runApp(const My_x_O_game());
}

class My_x_O_game extends StatelessWidget {
  const My_x_O_game({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
