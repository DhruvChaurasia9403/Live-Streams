import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeOverlay extends StatefulWidget {
  @override
  _FirstTimeOverlayState createState() => _FirstTimeOverlayState();
}

class _FirstTimeOverlayState extends State<FirstTimeOverlay> {
  bool _isFirstTime = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      setState(() {
        _isFirstTime = true;
      });
      prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isFirstTime,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isFirstTime = false;
          });
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Positioned(
              top: 16.5,
              right: 15.9,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Tap here to create stream",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 50, color: Theme.of(context).colorScheme.primaryContainer),
                  Icon(Icons.add, size: 50, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
            // Center(child: Text("Swipe to dismiss", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary))),
          ],
        ),
      ),
    );
  }
}