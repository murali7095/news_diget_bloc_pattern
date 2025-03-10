import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlickrAnimationWidget extends StatelessWidget {
  const FlickrAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        size: 100, // Size of the animation
        leftDotColor: Colors.blueAccent,
        rightDotColor: Colors.yellow, // Animation color
      ),
    );
  }
}
class CircularAnimationWidget extends StatelessWidget {
  const CircularAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        secondRingColor: Colors.red,
        size: 50, // Size of the animation
         color: Colors.blue, // Animation color
      ),
    );
  }
}

