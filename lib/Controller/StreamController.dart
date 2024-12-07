import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StreamsController extends GetxController {
  final RxList<Map<String, dynamic>> streams = <Map<String, dynamic>>[].obs;

  /// Fetches streams data from Firestore and updates the streams list.
  Future<void> fetchStreams() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('streams')
          .orderBy('title')
          .get();

      streams.value = querySnapshot.docs
          .map((doc) => {
        "id": doc.id,
        "url": doc['url'],
        "platform": doc['platform'],
        "title": doc['title'],
        "thumbnail": doc['thumbnail'], // Using the URL directly for thumbnail
      })
          .toList();
    } catch (e) {
      print("Error fetching streams: $e");
    }
  }

  /// Adds a new stream to Firestore and refreshes the streams list.
  Future<void> addStream(Map<String, dynamic> streamData) async {
    try {
      await FirebaseFirestore.instance.collection('streams').add(streamData);
      await fetchStreams(); // Refresh the list after adding a new stream.
    } catch (e) {
      print("Error adding stream: $e");
    }
  }
}
