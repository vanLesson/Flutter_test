import 'package:flutter/material.dart';

class CenterImage extends StatelessWidget {
  const CenterImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/img.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
