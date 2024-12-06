import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Model/UserModel.dart';
import 'package:http/http.dart' as http;

class ThumbnailController extends GetxController{
  final db = FirebaseFirestore.instance;
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    print("Initializing ThumbnailController...");
    await getUserDetails();
  }
  Future<void> getUserDetails() async{
    try{
      print("Fetching user details...");
      DocumentSnapshot<Map<String, dynamic>> userDoc = await db
        .collection('users')
        .doc(currentUser.value.id)
        .get();
      if(userDoc.exists){
        print("User data: ${userDoc.data()}");
        currentUser.value = UserModel.fromJson(userDoc.data()!);
      }else{
        print("No document found for the user.");
      }
    }catch(e){
      print("Error fetching user details: $e");
    }
  }


  Future<String?> uploadImageToCloudinary(String imagePath) async {
    try {
      const cloudName = "dgsxsujn9"; // Replace with your Cloudinary cloud name
      const uploadPreset = "profile_upload_unsigned";

      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      final request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        final res = await response.stream.bytesToString();
        final responseData = json.decode(res); // Parse the JSON response
        return responseData['secure_url']; // Extract and return the URL
      } else {
        print("Image upload failed: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Error uploading image to Cloudinary: $e");
      return null;
    }
  }


}