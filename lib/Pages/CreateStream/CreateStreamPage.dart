import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Controller/StreamController.dart';
import 'package:streamstreak/Controller/ThumbnailController.dart';
import 'package:streamstreak/Widgets/PrimaryButton.dart';
import 'package:streamstreak/Widgets/TextFields.dart';
import 'package:streamstreak/Controller/MetadataController.dart';

class CreateStreamPage extends StatefulWidget {
  const CreateStreamPage({super.key});

  @override
  State<CreateStreamPage> createState() => _CreateStreamPageState();
}

class _CreateStreamPageState extends State<CreateStreamPage> {
  final MetadataController metadataController = Get.put(MetadataController());
  final ThumbnailController thumbnailController = Get.put(ThumbnailController());
  final StreamsController streamsController = Get.put(StreamsController());
  final TextEditingController urlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final RxString imagePath = "".obs;
  String selectedPlatform = "YouTube";
  RxBool isFetchingMetadata = false.obs;

  Future<void> fetchMetadata(String url) async {
    if (url.isEmpty) {
      Get.snackbar("Error", "URL cannot be empty", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      isFetchingMetadata.value = true;
      final metadata = await metadataController.fetchMetadata(url);

      if (metadata != null) {
        titleController.text = metadata['title'] ?? "No Title";
        selectedPlatform = metadata['platform'] ?? "Other";
        imagePath.value = metadata['thumbnail'] ?? "";
        Get.snackbar("Success", "Metadata fetched successfully", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Metadata not found for the URL", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching metadata: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isFetchingMetadata.value = false;
    }
  }

  Future<void> publishStream() async {
    if (urlController.text.isEmpty || titleController.text.isEmpty || imagePath.value.isEmpty) {
      Get.snackbar("Error", "All fields are required", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      // Upload thumbnail to Cloudinary
      String? cloudinaryUrl = await thumbnailController.uploadImageToCloudinary(imagePath.value);
      if (cloudinaryUrl == null) {
        Get.snackbar("Error", "Failed to upload thumbnail", snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Save stream data to Firebase
      Map<String, dynamic> streamData = {
        "url": urlController.text,
        "platform": selectedPlatform,
        "title": titleController.text,
        "thumbnail": cloudinaryUrl,
      };
      await streamsController.addStream(streamData);
      Get.snackbar("Success", "Stream published successfully", snackPosition: SnackPosition.BOTTOM);
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "An error occurred while publishing the stream: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Stream",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("Stream URL", style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 8),
            Obx(() => Stack(
              alignment: Alignment.centerRight,
              children: [
                SearchHome(text: "Paste Your Streaming Link", controller: urlController),
                isFetchingMetadata.value
                    ? Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    fetchMetadata(urlController.text);
                  },
                ),
              ],
            )),
            SizedBox(height: 20),
            Text("Select Platform", style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPlatform,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedPlatform = value!;
                });
              },
              items: ["YouTube", "Twitch", "Facebook", "Other"]
                  .map((platform) => DropdownMenuItem(
                value: platform,
                child: Text(platform),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text("Stream Title", style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 8),
            SearchHome(text: "Video / Stream Title", controller: titleController),
            SizedBox(height: 20),
            Text("Choose Thumbnail", style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 8),
            Center(
              child: Obx(
                    () => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: (MediaQuery.of(context).size.width * 0.8) * (9 / 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                  child: imagePath.value.isEmpty
                      ? Icon(Icons.add, size: 50, color: Colors.grey)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imagePath.value,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Primarybutton(
                    btnName: "Cancel",
                    icon: Icons.cancel,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Primarybutton(
                    btnName: "Publish",
                    icon: Icons.upload,
                    onTap: publishStream,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}