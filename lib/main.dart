import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vim/firebase_options.dart';
import 'package:vim/vim.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Vim());
}
