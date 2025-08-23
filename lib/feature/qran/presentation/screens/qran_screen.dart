import 'package:flutter/material.dart';

class QranScreen extends StatelessWidget {
  const QranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '1', // رمز نهاية الآية
              style: TextStyle(fontSize: 24, fontFamily: 'Amiri'),
            ),
            Text(
              '\u06DD', // رمز نهاية الآية
              style: TextStyle(fontSize: 5, fontFamily: 'Amiri'),
            ),
          ],
        ),
      ),
    );
  }
}
