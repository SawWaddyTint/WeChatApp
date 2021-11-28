import 'dart:io';
import 'dart:typed_data';

import 'package:we_chat_app/data/vos/chat_vo.dart';
import 'package:we_chat_app/data/vos/liked_person_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

abstract class ChatDataAgent {
  Stream<List<ChatVO>> getMessageList();
  Future sendMessage(ChatVO chat);
  Future<String> uploadFileToFirebase(File image);
}
