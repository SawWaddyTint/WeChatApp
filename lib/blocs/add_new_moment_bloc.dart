import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:we_chat_app/data/models/we_chat_model.dart';
import 'package:we_chat_app/data/models/we_chat_model_impl.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

class AddNewMomentBloc extends ChangeNotifier {
  /// State
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isInEditMode = false;
  String userName = "";
  String profilePicture = "";
  MomentVO? mMoment;
  bool isVideo = false;
  bool showNetworkImg = false;

  /// Image
  File? chosenImageFile;
  bool isLoading = false;
  String imageUrl = "";
  File? videoFile;
  String? fileType = "";

  /// Model
  final WeChatModel _model = WeChatModelImpl();

  AddNewMomentBloc({int? newsFeedId}) {
    if (newsFeedId != null) {
      isInEditMode = true;

      _prepopulateDataForEditMode(newsFeedId);
    } else {
      _prepopulateDataForAddNewPost();
    }
    if (chosenImageFile == null) {
      showNetworkImg = true;
    } else {
      showNetworkImg = false;
    }
  }

  void _prepopulateDataForAddNewPost() {
    userName = "Waddy";
    profilePicture =
        "https://ziclife.com/wp-content/uploads/2020/08/cute-profile-picture-38-1024x963.jpg";
    _notifySafely();
  }

  void _prepopulateDataForEditMode(int newsFeedId) {
    _model.getNewsFeedById(newsFeedId).listen((newsFeed) {
      chosenImageFile = null;
      userName = newsFeed.userName ?? "";
      profilePicture = newsFeed.profilePicture ?? "";
      newPostDescription = newsFeed.description ?? "";
      imageUrl = newsFeed.postImage ?? "";
      mMoment = newsFeed;
      _notifySafely();
    });
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void onNewPostTextChanged(String newPostDescription) {
    this.newPostDescription = newPostDescription;
  }

  Future onTapAddNewPost() {
    if (newPostDescription.isEmpty) {
      isAddNewPostError = true;
      if (!isDisposed) {
        _notifySafely();
      }
      return Future.error("error");
    } else {
      isLoading = true;
      _notifySafely();
      isAddNewPostError = false;
      if (isInEditMode) {
        return _editNewsFeedPost();
      } else {
        return _createNewNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
        });
      }
    }
  }

  Future<dynamic> _editNewsFeedPost() {
    mMoment?.description = newPostDescription;

    if (mMoment != null) {
      return _model.editPost(mMoment!, chosenImageFile, fileType);
    } else {
      return Future.error("Error");
    }
  }

  Future<void> _createNewNewsFeedPost() {
    return _model.addNewPost(newPostDescription, chosenImageFile, fileType);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void onImageChosen(File filePath, String fileName) {
    showNetworkImg = false;
    chosenImageFile = filePath;
    String? mimeStr = lookupMimeType(fileName);
    var fileTypeList = mimeStr?.split('/');
    if (fileTypeList?[1] == 'mp4') {
      isVideo = true;
      videoFile = filePath;
      fileType = 'video';
    } else {
      isVideo = false;
      fileType = 'image';
    }

    print('file type ${fileType}');

    _notifySafely();
  }

  void onTapDeleteImage() {
    chosenImageFile = null;
    showNetworkImg = true;
    imageUrl = "";
    _notifySafely();
  }

  // Future<void> fileToUint8List(File imageFile) async {
  //   Uint8List imageRaw = await imageFile.readAsBytes();
  //   this.onImageChosen(imageRaw);
  // }

  UrlToUint8List(String imageUrl) async {
    debugPrint("image Url is >>> " + imageUrl);
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
    final Uint8List bytes = imageData.buffer.asUint8List();
// display it with the Image.memory widget
    Image.memory(bytes);
  }
}
