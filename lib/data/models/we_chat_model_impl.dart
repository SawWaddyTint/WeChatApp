import 'dart:io';
import 'dart:typed_data';

import 'package:we_chat_app/data/models/we_chat_model.dart';
import 'package:we_chat_app/data/vos/liked_person_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

import 'package:we_chat_app/main.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/real_time_database_data_agent_impl.dart';
import 'package:we_chat_app/network/we_chat_data_agent.dart';
import 'package:uuid/uuid.dart';

class WeChatModelImpl extends WeChatModel {
  static final WeChatModelImpl _singleton = WeChatModelImpl._internal();

  factory WeChatModelImpl() {
    return _singleton;
  }

  WeChatModelImpl._internal();

  // SocialDataAgent mDataAgent = RealtimeDatabaseDataAgentImpl();
  WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  @override
  Stream<List<MomentVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

  @override
  Future<void> addNewPost(
      String description, File? imageFile, String? fileType) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) =>
              craftMomentVO(description, downloadUrl, fileType))
          .then((newPost) => mDataAgent.addNewPost(newPost));
    } else {
      return craftMomentVO(description, "", fileType)
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }
  }

  var currentMilliseconds = DateTime.now().microsecondsSinceEpoch;
  var uuid = const Uuid();
  Future<MomentVO> craftMomentVO(
      String description, String imageUrl, String? fileType) {
    var newPost = MomentVO(
        id: DateTime.now().microsecondsSinceEpoch,
        userName: "Waddy",
        postImage: imageUrl,
        description: description,
        profilePicture:
            "https://ziclife.com/wp-content/uploads/2020/08/cute-profile-picture-38-1024x963.jpg",
        createdDate: DateTime.now().toString(),
        likedPerson: [],
        isLiked: false,
        fileType: fileType);
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Stream<MomentVO> getNewsFeedById(int newsFeedId) {
    return mDataAgent.getNewsFeedById(newsFeedId);
  }

  @override
  Future<void> editPost(MomentVO newsFeed, File? imageFile, String? fileType) {
    if (imageFile != null) {
      return mDataAgent.uploadFileToFirebase(imageFile).then((downloadUrl) {
        newsFeed.postImage = downloadUrl;
        mDataAgent.addNewPost(newsFeed);
      });
    } else {
      return mDataAgent.addNewPost(newsFeed);
    }
  }

  @override
  Future<void> likePost(int postId, bool isLiked, Map likedPerson) {
    return mDataAgent.likePost(postId, isLiked, likedPerson);
  }
}
