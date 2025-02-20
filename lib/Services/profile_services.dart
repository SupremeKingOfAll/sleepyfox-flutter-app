import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to add a child profile
  Future<void> addChildProfile(String name, int age, String email) async {
    CollectionReference childProfiles =
        FirebaseFirestore.instance.collection('childProfiles');
    try {
      await childProfiles.add({
        'name': name,
        'age': age,
        'email': email,
      });
      print("Child Profile Added");
    } catch (error) {
      print("Failed to add child profile: $error");
    }
  }

  // Fetch all profiles (not filtered)
  Future<List<Map<String, dynamic>>> fetchChildProfiles() async {
    CollectionReference childProfiles =
        FirebaseFirestore.instance.collection('childProfiles');

    QuerySnapshot querySnapshot = await childProfiles.get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Fetch profiles associated with the logged-in user's email
  Future<List<Map<String, dynamic>>> fetchChildProfilesForCurrentUser() async {
    try {
      final String? userEmail = _auth.currentUser?.email;
      if (userEmail == null) {
        throw Exception("User is not logged in.");
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('childProfiles')
          .where('email', isEqualTo: userEmail)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Failed to fetch child profiles for current user: $e");
      return [];
    }
  }
}
