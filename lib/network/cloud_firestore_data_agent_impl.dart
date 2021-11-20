import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/liked_person_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/network/we_chat_data_agent.dart';

/// News Feed Collection
const momentCollection = "moments";
const fileUploadRef = "uploads";

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addNewPost(MomentVO newPost) {
    return _fireStore
        .collection(momentCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(momentCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<List<MomentVO>> getNewsFeed() {
    return _fireStore
        .collection(momentCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<MomentVO>((document) {
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Stream<MomentVO> getNewsFeedById(int newsFeedId) {
    return _fireStore
        .collection(momentCollection)
        .doc(newsFeedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => MomentVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime.now().microsecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future<void> likePost(int postId, bool isLiked, Map likedPerson) {
    return _fireStore
        .collection(momentCollection)
        .doc(postId.toString())
        .update({
      'liked_person': [likedPerson],
      'is_liked': isLiked
    });
  }
}
