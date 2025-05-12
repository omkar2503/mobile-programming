import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  // Create a new user
  Future<void> createUser(UserModel user) async {
    await _firestore.collection(_collection).add(user.toMap());
  }

  // Get all users
  Stream<List<UserModel>> getUsers() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // Update a user
  Future<void> updateUser(UserModel user) async {
    if (user.id != null) {
      await _firestore.collection(_collection).doc(user.id).update(user.toMap());
    }
  }

  // Delete a user
  Future<void> deleteUser(String userId) async {
    await _firestore.collection(_collection).doc(userId).delete();
  }
} 