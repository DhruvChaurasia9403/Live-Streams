import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:streamstreak/Config/Keys.dart';

class MetadataController extends GetxController {

  Future<Map<String, String>?> fetchMetadata(String url) async {
    try {
      if (!Uri.parse(url).isAbsolute) {
        throw Exception("Invalid URL format");
      }
      final apiUrl = Uri.parse("https://api.linkpreview.net/?key=$apiKey&q=$url");
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "title": data['title'] ?? "No Title",
          "description": data['description'] ?? "No Description",
          "thumbnail": data['image'] ?? "",
          "platform": _detectPlatform(url),  // Detect platform based on URL or other metadata
        };
      } else {
        print("API Error: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Error fetching metadata: $e");
      return null;
    }
  }

  // A simple heuristic to detect platform based on URL (this can be improved)
  String _detectPlatform(String url) {
    if (url.contains("youtube.com") || url.contains("youtu.be")) {
      return "YouTube";
    } else if (url.contains("twitch.tv")) {
      return "Twitch";
    } else if (url.contains("facebook.com")) {
      return "Facebook";
    }
    return "Other";  // Default platform
  }
}
