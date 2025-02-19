import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileServices {
  // Function to add a child profile
  Future<void> addChildProfile(String name, int age) async {
    CollectionReference childProfiles =
        FirebaseFirestore.instance.collection('childProfiles');
//error handling
    try {
      await childProfiles.add({
        'name': name,
        'age': age,
      });
      print("Child Profile Added");
    } catch (error) {
      print("Failed to add child profile: $error");
    }
  }

  // Function to fetch child profiles
  Future<List<Map<String, dynamic>>> fetchChildProfiles() async {
    CollectionReference childProfiles =
        FirebaseFirestore.instance.collection('childProfiles');

    QuerySnapshot querySnapshot = await childProfiles.get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
