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
              color: Colors.black54,
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Tap here to create a stream",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Icon(Icons.arrow_downward, size: 50, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}