import 'package:flutter/material.dart';

import 'package:term_project/MyAppState.dart';

class MyApp extends StatefulWidget {
  // constructor with initializer list (execute before constructor)
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() {
    return MyAppState();
  }
}