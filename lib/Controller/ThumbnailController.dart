import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Config/Keys.dart';
import 'package:streamstreak/Model/UserModel.dart';
import 'package:http/http.dart' as http;

class ThumbnailController extends GetxController {
  final db = FirebaseFirestore.instance;
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await db
          .collection('users')
          .doc(currentUser.value.id)
          .get();
      if (userDoc.exists) {
        currentUser.value = UserModel.fromJson(userDoc.data()!);
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<String?> uploadImageToCloudinary(String imageUrl) async {
    try {
      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      final response = await http.post(
        url,
        body: {
          'upload_preset': uploadPreset,
          'file': imageUrl,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['secure_url'];
      } else {
        print("Image upload failed: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Error uploading image to Cloudinary: $e");
      return null;
    }
  }

  Future<void> uploadUserDetails(Map<String, dynamic> data) async {
    try {
      await db.collection('users').doc(currentUser.value.id).update(data);
      await getUserDetails();
    } catch (e) {
      print("Error updating user details: $e");
    }
  }
}