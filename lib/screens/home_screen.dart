import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final newsId = 'MyFirstNews';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home page')),
        body: Column(
          children: [
            GestureDetector(
              onTap: () => context.go('/one_news/:$newsId'),
              child: Card(child: Text('Новость')),
            ),
          ],
        ),
      ),
    );
  }
}
