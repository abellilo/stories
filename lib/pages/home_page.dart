import 'package:flutter/material.dart';

import '../util/story_circles.dart';
import 'story_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openStory() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoryPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('S T O R I E S'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return StoryCircle(
                    function: _openStory,
                  );
                }),
          )
        ],
      ),
    );
  }
}
