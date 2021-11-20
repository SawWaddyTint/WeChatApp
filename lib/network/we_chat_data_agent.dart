import 'dart:io';
import 'dart:typed_data';

import 'package:we_chat_app/data/vos/liked_person_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

abstract class WeChatDataAgent {
  Stream<List<MomentVO>> getNewsFeed();
  Future<void> addNewPost(MomentVO newPost);
  Future<void> deletePost(int postId);
  Stream<MomentVO> getNewsFeedById(int newsFeedId);
  Future<String> uploadFileToFirebase(File image);
  Future<void> likePost(int postId, bool isLiked, Map likedPerson);
}
