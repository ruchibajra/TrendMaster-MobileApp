import 'package:flutter/material.dart';

class CheckImagePage extends StatelessWidget {
  final String imageUrl;

  CheckImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Image"),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
