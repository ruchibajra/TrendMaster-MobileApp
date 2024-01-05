import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String niche;

  CategoryPage({required this.niche});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page - $niche'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the $niche Category Page',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            _renderNicheContent(niche),
          ],
        ),
      ),
    );
  }

  Widget _renderNicheContent(String niche) {
    switch (niche) {
      case 'lifestyle':
        return Text('Explore articles and tips on a healthy lifestyle.');
      case 'education':
        return Text('Discover educational resources and information.');
      case 'fashion':
        return Text('Stay updated with the latest fashion trends and styles.');
      default:
        return Text('No specific content for $niche yet.');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryPage(niche: 'education'), // Specify the niche here
    );
  }
}
