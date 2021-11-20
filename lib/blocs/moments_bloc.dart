import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/we_chat_model.dart';
import 'package:we_chat_app/data/models/we_chat_model_impl.dart';
import 'package:we_chat_app/data/vos/liked_person_vo.dart';

import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:timeago/timeago.dart' as timeago;

class MomentsBloc extends ChangeNotifier {
  List<MomentVO>? moment;
  bool showLikedPerson = false;
  final WeChatModel _mSocialModel = WeChatModelImpl();
  bool isLiked = false;

  bool isDisposed = false;

  MomentsBloc() {
    _mSocialModel.getNewsFeed().listen((newsFeedList) {
      moment = newsFeedList;
      moment?.forEach((element) {
        element.createdDate =
            timeago.format(DateTime.parse(element.createdDate ?? ""));

        if ((element.likedPerson?.length ?? 0) > 0) {
          element.showLikedPerson = true;
        }
      });
      if (!isDisposed) {
        notifyListeners();
      }
    });
  }

  void onTapDeletePost(int postId) async {
    await _mSocialModel.deletePost(postId);
  }

  void onTapLikePost(MomentVO mMoment) async {
    var currentMilliseconds = DateTime.now().microsecondsSinceEpoch + 3;

    mMoment.likedPerson?.add(LikedPersonVO(
        likedPersonId: currentMilliseconds, likedPersonName: "Waddy"));

    List<LikedPersonVO>? likedPersonList = mMoment.likedPerson;
    likedPersonList?.map((e) => e as Map<String, dynamic>).toList();

    // var json = jsonEncode(likedPersonList?.map((e) => e.toJson()).toList());

    // LikedPersonVO(likedPersonId: currentMilliseconds, likedPersonName: "Waddy")
    //     .toJson();

    mMoment.isLiked = !isLiked;
    notifyListeners();
    _mSocialModel.likePost(
        mMoment.id ?? 0,
        mMoment.isLiked ?? false,
        LikedPersonVO(
                likedPersonId: currentMilliseconds, likedPersonName: "Waddy")
            .toJson());
    _mSocialModel.getNewsFeed().listen((newsFeedList) {
      moment = newsFeedList;
      moment?.forEach((element) {
        element.createdDate =
            timeago.format(DateTime.parse(element.createdDate ?? ""));

        if ((element.likedPerson?.length ?? 0) > 0) {
          element.showLikedPerson = true;
          if (!isDisposed) {
            notifyListeners();
          }
        }
      });
      if (!isDisposed) {
        notifyListeners();
      }
      // } else {
      //   moment.likedPerson?[moment.likedPerson?.length ?? 0].likedPersonName =
      //       "Waddy";
      //   moment.likedPerson?[moment.likedPerson?.length ?? 0].likedPersonId =
      //       currentMilliseconds;
      //   isLiked = !isLiked;
      //   moment.isLiked = isLiked;
      //   _mSocialModel.likePost(moment);
      //   notifyListeners();
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
