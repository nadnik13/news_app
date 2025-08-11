

import 'package:flutter/material.dart';

class OneNewsScreen extends StatefulWidget{
  final String? id;
  const OneNewsScreen({super.key, required this.id});

  @override
  State<OneNewsScreen> createState() => _OneNewsScreenState();
}

class _OneNewsScreenState extends State<OneNewsScreen>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppBar(
        title: Text('One news page ${widget.id}'),
      ),
    );
  }
}