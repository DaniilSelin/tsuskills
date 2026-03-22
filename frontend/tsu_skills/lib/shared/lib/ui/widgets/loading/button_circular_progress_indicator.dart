import 'package:flutter/material.dart';

class ButtonCircularProgressIndicator extends StatelessWidget {
  const ButtonCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
