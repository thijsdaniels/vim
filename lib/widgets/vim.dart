import 'package:flutter/material.dart';
import 'package:vim/widgets/views/tabs.dart';

class Vim extends StatelessWidget {
  const Vim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vim',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Tabs(),
    );
  }
}
