import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHome extends StatelessWidget {
  final Icon? icon;
  final String text;
  final TextEditingController? controller;

  const SearchHome({
    super.key,
    required this.text,
    this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isFocused = false.obs;
    FocusNode focusNode = FocusNode();

    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });

    return Obx(
          () => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isFocused.value
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondary,
          ),
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
              hintText: text,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: icon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
      ),
    );
  }
}
