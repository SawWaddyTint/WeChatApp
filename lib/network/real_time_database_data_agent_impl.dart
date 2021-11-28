import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/chat_vo.dart';
import 'package:we_chat_app/data/vos/liked_person_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/network/chat_data_agent.dart';

import 'package:we_chat_app/network/we_chat_data_agent.dart';

/// Database Paths
const chatDbPath = "chat";
const fileUploadRef = "uploads";

class RealtimeDatabaseDataAgentImpl extends ChatDataAgent {
  static final RealtimeDatabaseDataAgentImpl _singleton =
      RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealtimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.reference();
  var firebaseStorage = FirebaseStorage.instance;

  // @override
  // Stream<List<MomentVO>> getNewsFeed() {
  //   return databaseRef.child(newsFeedPath).onValue.map((event) {
  //     // event.snapshot.value => Map<String, dynamic> => values => List<Map<String,dynamic>> => map => List<MomentVO>
  //     return event.snapshot.value.values.map<MomentVO>((element) {
  //       return MomentVO.fromJson(Map<String, dynamic>.from(element));
  //     }).toList();
  //   });
  // }

  // @override
  // Future<void> addNewPost(MomentVO newPost) {
  //   return databaseRef
  //       .child(newsFeedPath)
  //       .child(newPost.id.toString())
  //       .set(newPost.toJson());
  // }

  // @override
  // Future<void> deletePost(int postId) {
  //   return databaseRef.child(newsFeedPath).child(postId.toString()).remove();
  // }

  // @override
  // Stream<MomentVO> getNewsFeedById(int newsFeedId) {
  //   return databaseRef
  //       .child(newsFeedPath)
  //       .child(newsFeedId.toString())
  //       .once()
  //       .asStream()
  //       .map((snapshot) {
  //     return MomentVO.fromJson(Map<String, dynamic>.from(snapshot.value));
  //   });
  // }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime.now().microsecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  // @override
  // Future<void> likePost(int postId, bool isLiked, Map likedPerson) {
  //   // TODO: implement likePost
  //   throw UnimplementedError();
  // }

  @override
  Stream<List<ChatVO>> getMessageList() {
    return databaseRef.child(chatDbPath).onValue.map((event) {
      // event.snapshot.value => Map<String, dynamic> => values => List<Map<String,dynamic>> => map => List<MomentVO>
      return event.snapshot.value.values.map<ChatVO>((element) {
        return ChatVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Future sendMessage(ChatVO chat) {
    return databaseRef
        .child(chatDbPath)
        .child(chat.id.toString())
        .set(chat.toJson());
  }
}
