import 'dart:io';
import 'dart:typed_data';

import 'package:we_chat_app/data/vos/liked_person_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

abstract class WeChatModel {
  Stream<List<MomentVO>> getNewsFeed();
  Future<void> addNewPost(
      String description, File? imageFile, String? fileType);
  Future<void> editPost(MomentVO newsFeed, File? imageFile, String? fileType);
  Future<void> deletePost(int postId);
  Stream<MomentVO> getNewsFeedById(int newsFeedId);
  Future<void> likePost(int postId, bool isLiked, Map likedPerson);
}
