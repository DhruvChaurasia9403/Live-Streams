import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Controller/StreamController.dart';
import 'package:streamstreak/Controller/ThumbnailController.dart';
import 'package:streamstreak/Controller/ImagePickerController.dart';
import 'package:streamstreak/Widgets/PrimaryButton.dart';
import 'package:streamstreak/Widgets/TextFields.dart';

class EditStreamPage extends StatefulWidget {
  const EditStreamPage({super.key});

  @override
  State<EditStreamPage> createState() => _EditStreamPageState();
}

class _EditStreamPageState extends State<EditStreamPage> {
  final StreamsController streamsController = Get.put(StreamsController());
  final ThumbnailController thumbnailController = Get.put(ThumbnailController());
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final RxString imagePath = "".obs;
  late Map<String, dynamic> stream;

  @override
  void initState() {
    super.initState();
    stream = Get.arguments ?? {};
    titleController.text = stream['title'] ?? '';
    urlController.text = stream['url'] ?? '';
    imagePath.value = stream['thumbnail'] ?? '';
  }

  Future<void> updateStream() async {
    if (titleController.text.isEmpty || imagePath.value.isEmpty) {
      Get.snackbar("Error", "All fields are required", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      String? cloudinaryUrl = imagePath.value != stream['thumbnail']
          ? await thumbnailController.uploadImageToCloudinary(imagePath.value)
          : stream['thumbnail'];

      if (cloudinaryUrl == null) {
        Get.snackbar("Error", "Failed to upload thumbnail", snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Update stream data in Firebase
      Map<String, dynamic> updatedStreamData = {
        "title": titleController.text,
        "thumbnail": cloudinaryUrl,
      };
      await streamsController.updateStream(stream['id'], updatedStreamData);
      Get.snackbar("Success", "Stream updated successfully", snackPosition: SnackPosition.BOTTOM);
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "An error occurred while updating the stream: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> pickImage() async {
    String newImagePath = await imagePickerController.pickImage();
    if (newImagePath.isNotEmpty) {
      imagePath.value = newImagePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Stream",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Stream URL", style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              TextFormField(
                controller: urlController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Stream Title", style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              SearchHome(text: "Video / Stream Title", controller: titleController),
              SizedBox(height: 20),
              Text("Thumbnail", style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              InkWell(
                onTap: pickImage,
                child: Center(
                  child: Obx(
                        () => Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: (MediaQuery.of(context).size.width * 1) * (9 / 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      child: imagePath.value.isEmpty
                          ? Icon(Icons.image, size: 50, color: Colors.grey)
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
              ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: pickImage,
              //   child: Text("Change Thumbnail"),
              // ),
              SizedBox(height: 180),
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
                      btnName: "Update",
                      icon: Icons.upload,
                      onTap: updateStream,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}