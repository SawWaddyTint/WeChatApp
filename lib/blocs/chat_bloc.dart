import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:we_chat_app/data/models/we_chat_model.dart';
import 'package:we_chat_app/data/models/we_chat_model_impl.dart';
import 'package:we_chat_app/data/vos/chat_vo.dart';

class ChatBloc extends ChangeNotifier {
  ///State
  ChatVO? chat;
  List<ChatVO>? chatList;
  File? filePath;
  String fileName = "";
  bool isDisposed = false;
  bool hasData = false;
  String? message;
  String type = "text";
  TextEditingController? controller;
  File? filePathToSend;
  bool isLoading = false;
  bool isVideo = false;
  bool showOptions = false;

  /// Model
  final WeChatModel _mChatmodel = WeChatModelImpl();

  ChatBloc() {
    _mChatmodel.getMessageList().listen((messages) {
      chatList = messages;
      for (int i = 0; i < (chatList?.length ?? 0); i++) {
        if (chatList?[i].type == "image" || chatList?[i].type == "video") {
          if (chatList?[i].text != "") {
            chatList?[i].textWithFile = true;
            _notifySafely();
          } else {
            chatList?[i].textWithFile = false;
            _notifySafely();
          }
        } else {
          chatList?[i].textWithFile = false;
          _notifySafely();
        }
      }
      if (!isDisposed) {
        notifyListeners();
      }
    });
  }
  void uploadFile(File file, String name) {
    fileName = name;
    String? mimeStr = lookupMimeType(fileName);
    var fileTypeList = mimeStr?.split('/');
    if (fileTypeList?[1] == 'mp4') {
      isVideo = true;

      _notifySafely();
    } else {
      isVideo = false;

      _notifySafely();
    }
    if (file != null) {
      filePath = file;
      hasData = true;
      showOptions = false;
      // hasData = true;
      _notifySafely();
    } else {
      hasData = false;
      showOptions = false;
      _notifySafely();
    }
  }

  void onTextChanged(String message, TextEditingController ct) {
    controller = ct;
    this.message = message;
    if (this.message != null && this.message != "") {
      this.hasData = true;
      _notifySafely();
    } else {
      this.hasData = false;
      _notifySafely();
    }
  }

  Future sendMessage() {
    isLoading = true;
    if (filePath != null) {
      filePathToSend = filePath;
      filePath = null;
      controller?.clear();
      _notifySafely();
      String? mimeStr = lookupMimeType(fileName);
      var fileTypeList = mimeStr?.split('/');
      if (fileTypeList?[1] == "mp4") {
        type = "video";
      } else {
        type = "image";
      }
    } else {
      type = "text";
    }

    return _mChatmodel
        .sendMessage(message ?? "", type, filePathToSend)
        .then((value) {
      filePathToSend = null;
      message = "";
      controller?.clear();
      isLoading = false;
      showOptions = false;
      hasData = false;
      // filePathToSend = null;
      _notifySafely();
    });
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void showOpt() {
    showOptions = true;
    _notifySafely();
  }

  void closeOpt() {
    showOptions = false;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
