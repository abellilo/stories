import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final function;
  const StoryCircle({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:  Colors.blue,
          ),
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
