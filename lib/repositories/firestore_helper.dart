import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gd_chat/models/app_user.dart';
import 'package:gd_chat/models/message.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  final String usersCollectionName = 'Users';
  final String chatsCollectionName = 'Chats';
  final String messagesCollectionName = 'Messages';
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  registerUser(AppUser appUser) async {
    firebaseFirestore
        .collection(usersCollectionName)
        .doc(appUser.userId)
        .set(appUser.toMap());
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection(usersCollectionName).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> query =
        querySnapshot.docs;
    return query;
  }

  sendMessage(Message message) async {
    message.sentTime = FieldValue.serverTimestamp();
    await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(message.chatId)
        .collection(messagesCollectionName)
        .add(message.toMap());
  }

  Future<bool> checkCollectionExists(String chatiD) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatiD)
        .get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  createChat(String chatId, AppUser myUser, AppUser otherUser) async {
    await firebaseFirestore.collection(chatsCollectionName).doc(chatId).set({
      'membersIds': [myUser.userId, otherUser.userId],
      'membersNames': [myUser.name, otherUser.name]
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChats() async {
    String? myId = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(chatsCollectionName)
        .where('membersIds', arrayContains: myId)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    return docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {
    return firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatId)
        .collection(messagesCollectionName)
        .orderBy('sentTime')
        .snapshots();
  }
}
