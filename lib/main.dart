import 'package:flutter/material.dart';
import 'widgets/wave_progress_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave Progress Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const WaveProgressDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}