import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stories/util/story_bars.dart';

import '../stories/story_1.dart';
import '../stories/story_2.dart';
import '../stories/story_3.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;

  final List<Widget> myStories = [Story1(), Story2(), Story3()];

  List<double> percentWatched = [];

  @override
  void initState() {
    //initially all stories haven't been watched yet
    for(int i=0; i<myStories.length; i++){
      percentWatched.add(0);
    }

    _startWatching();
    super.initState();
  }

  void _startWatching(){
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        //add 0.01 only when its below 1
        if(percentWatched[currentStoryIndex] + 0.01 < 1){
          percentWatched[currentStoryIndex] +=0.01;
        }
        //if adding 0.01 exceeed 1 set percentage to 1 and cancel timer
        else{
          percentWatched[currentStoryIndex] = 1;
          timer.cancel();

          //also go to the next story as lng there is another story to go through
          if(currentStoryIndex < myStories.length -1){
            currentStoryIndex++;
            //restart story timer
            _startWatching();
          }
          //if finishing the last story return to homepage
          else{
            Navigator.pop(context);
          }
        }
      });
    });
  }

  void _onTapDown(TapDownDetails details){
    final double screenwidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    //user taps on first half of the screen
    if(dx < screenwidth/2){
      setState(() {
        //as long as its not the first story
        if(currentStoryIndex > 0){
          //set previous and current story watched back to zero(0)
          percentWatched[currentStoryIndex - 1] = 0;
          percentWatched[currentStoryIndex] = 0;

          //go to previous story
          currentStoryIndex--;
        }
      });
    }
    //user taps on second halkf of the screen
    else{
      setState(() {
        //if there are more stories left
        if(currentStoryIndex < myStories.length -1){
          //finish current story
          percentWatched[currentStoryIndex] = 1;
          //move to the next story
          currentStoryIndex++;
        }
        //if user is on the last story
        else{
          percentWatched[currentStoryIndex] = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:(details) =>  _onTapDown(details),
      child: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Stack(
            children: [
              //story
              myStories[currentStoryIndex],

              //progress bar
              MyStoryBars(
                percentWatched: percentWatched,
              )
            ],
          )),
    );
  }
}
