import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphics_cycle/screens/meme_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: MemeApp()));
}

class MemeApp extends StatelessWidget {
  const MemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemeListScreen(),
    );
  }
}
