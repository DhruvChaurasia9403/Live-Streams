import 'package:flutter/material.dart';
import 'package:streamstreak/Pages/Welcome/SliderButton.dart';
class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Center(child: Text("Live Streams",style:Theme.of(context).textTheme.headlineLarge))),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:Sliderbutton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
