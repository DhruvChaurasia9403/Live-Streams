import 'package:flutter/material.dart';

class Primarybutton extends StatelessWidget {
  final String? btnName;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? color;
  const Primarybutton({super.key,this.btnName , this.icon, required this.onTap , this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap:onTap,
          child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
              decoration: BoxDecoration(
                color: color??Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon??null),
                  const SizedBox(width:10),
                  btnName == null ? SizedBox.shrink()
                      : Text(
                      btnName!,
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )
          ),
        ),
      ],
    );
  }
}
