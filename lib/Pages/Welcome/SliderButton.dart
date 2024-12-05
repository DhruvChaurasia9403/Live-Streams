import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
class Sliderbutton extends StatelessWidget {
  const Sliderbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideAction(
          onSubmit: (){
            Get.offAllNamed('/homePage');
          },
          text: "Go Stream",
          sliderRotate: true,
          innerColor: Theme.of(context).colorScheme.primaryContainer,
          outerColor: Theme.of(context).colorScheme.onPrimaryContainer,
          sliderButtonIconSize: 25,
          sliderButtonIcon: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }
}
