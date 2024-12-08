import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class StreamsController extends GetxController {
  final RxList<Map<String, dynamic>> streams = <Map<String, dynamic>>[].obs;

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
        "thumbnail": doc['thumbnail'],
      })
          .toList();
    } catch (e) {
      print("Error fetching streams: $e");
    }
  }

  Future<void> addStream(Map<String, dynamic> streamData) async {
    try {
      await FirebaseFirestore.instance.collection('streams').add(streamData);
      await fetchStreams();
    } catch (e) {
      print("Error adding stream: $e");
    }
  }

  Future<void> deleteStream(String streamId) async {
    try {
      await FirebaseFirestore.instance.collection('streams').doc(streamId).delete();
      await fetchStreams();
    } catch (e) {
      print("Error deleting stream: $e");
    }
  }
  Future<void> updateStream(String streamId, Map<String, dynamic> updatedStreamData) async {
    try {
      await FirebaseFirestore.instance.collection('streams').doc(streamId).update(updatedStreamData);
      await fetchStreams();
    } catch (e) {
      print("Error updating stream: $e");
    }
  }
}