// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/moments_bloc.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/viewitems/video_view.dart';
import 'package:we_chat_app/widgets/profile_image_view.dart';

class MomentItemView extends StatelessWidget {
  final MomentVO? mMoment;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;
  final Function(MomentVO) onTapLike;

  MomentItemView({
    Key? key,
    required this.mMoment,
    required this.onTapDelete,
    required this.onTapEdit,
    required this.onTapLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> likedPerson = ['Nuno Rocha', 'Amie Deane', 'Alan Lu'];

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // ignore: prefer__literals_to_create_immutables
                  children: [
                    ProfileImageView(
                      profileImage: mMoment?.profilePicture ?? "",
                      // profileImage:
                      //     "https://www.whatsappimages.in/wp-content/uploads/2021/05/Cartoon-Whatsapp-DP.jpg",
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM_2,
                    ),
                    NameLocationAndTimeAgoView(
                      userName: mMoment?.userName ?? "",
                      timeAgo: mMoment?.createdDate ?? "",
                      // userName: "David William",
                    ),
                    Spacer(),
                    // MoreButtonView(
                    //   onTapDelete: () {
                    //     onTapDelete(mMoment?.id ?? 0);
                    //   },
                    //   onTapEdit: () {
                    //     onTapEdit(mMoment?.id ?? 0);
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: PostDescriptionView(
                    description: mMoment?.description ?? "",
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Visibility(
                  visible: ((mMoment?.postImage ?? "").isNotEmpty),
                  child: (mMoment?.fileType == "image")
                      ? PostImageView(
                          postImage: mMoment?.postImage ?? "",
                          // postImage:
                          //     "https://onecms-res.cloudinary.com/image/upload/s--njKklIAd--/c_fill%2Cg_auto%2Ch_468%2Cw_830/fl_relative%2Cg_south_east%2Cl_one-cms:core:watermark:reuters%2Cw_0.1/f_auto%2Cq_auto/v1/one-cms/core/2021-11-17t155948z_1_lynxmpehag0wf_rtroptp_3_usa-china-biden-xi.jpg?itok=n9SJcXp1",
                        )
                      : VideoView(File(""), mMoment?.postImage ?? ""),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: duplicate_ignore
                  children: [
                    // Spacer(),
                    // ignore: prefer_const_constructors
                    (mMoment?.isLiked ?? false)
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              if (mMoment != null) {
                                onTapLike(mMoment!);
                              }
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              if (mMoment != null) {
                                onTapLike(mMoment!);
                              }
                            },
                          ),
                    // ignore: prefer_const_constructors
                    // SizedBox(
                    //   width: MARGIN_MEDIUM,
                    // ),
                    // ignore: prefer_const_constructors
                    Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    MoreButtonView(
                      onTapDelete: () {
                        onTapDelete(mMoment?.id ?? 0);
                      },
                      onTapEdit: () {
                        onTapEdit(mMoment?.id ?? 0);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: mMoment?.showLikedPerson ?? false,
          child: Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Container(
              height: 250,
              color: MOMENTS_BG_COLOR,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Row(
                          // ignore: prefer__literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Color.fromRGBO(66, 66, 66, 1.0),
                              size: 18.0,
                            ),
                            SizedBox(
                              width: MARGIN_MEDIUM,
                            ),
                            Wrap(
                                children: mMoment?.likedPerson
                                        ?.map((e) => LikedPerson(
                                            e.likedPersonName ?? ""))
                                        .toList() ??
                                    [])
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer__literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.mode_comment_rounded,
                            color: Color.fromRGBO(66, 66, 66, 1.0),
                            size: 18.0,
                          ),
                          SizedBox(
                            width: MARGIN_MEDIUM,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 300,
                                width: 280.0,
                                // width: double.infinity,
                                child: ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text.rich(
                                      TextSpan(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          TextSpan(
                                            text: 'David William',
                                            style: TextStyle(
                                              // fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  78, 78, 78, 1.0),
                                            ),
                                          ),
                                          TextSpan(text: " "),
                                          TextSpan(
                                              text:
                                                  'A good job description is critical for attracting the right candidates. Use one of Monsters 500+ templates to write a job posting that works.',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              )),
                                          //                                   WidgetSpan(
                                          //   child: SizedBox(
                                          //     width: 120,
                                          //     height: 50,
                                          //     child: Card(
                                          //       child: Center(
                                          //         child: Text('A good job description is critical for attracting the right candidates. Use one of Monsters 500+ templates to write a job posting that works.')
                                          //       )
                                          //     ),
                                          //   )
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      // Container(
                      //   height: 100,
                      //   width: 100,
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.mode_comment_rounded,
                      //         color: Color.fromRGBO(66, 66, 66, 1.0),
                      //       ),
                      //       SizedBox(
                      //         width: MARGIN_MEDIUM,
                      //       ),
                      //       ListView(
                      //         children: [],
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6.0,
        )
      ],
    );
  }
}

class LikedPerson extends StatelessWidget {
  final String name;
  LikedPerson(this.name);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(78, 78, 78, 1.0),
      ),
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String description;

  PostDescriptionView({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.grey,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  final String postImage;

  PostImageView({
    Key? key,
    required this.postImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_SMALL),
      child: FadeInImage(
        height: 200,
        width: double.infinity,
        placeholder: NetworkImage(
          NETWORK_IMAGE_POST_PLACEHOLDER,
        ),
        image: NetworkImage(
          postImage,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  MoreButtonView({
    Key? key,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.only(right: 10.0),
      icon: Icon(
        Icons.more_horiz_outlined,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            onTapEdit();
          },
          child: Text("Edit"),
          value: 1,
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          child: Text("Delete"),
          value: 2,
        )
      ],
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  final String userName;
  final String timeAgo;

  NameLocationAndTimeAgoView({
    Key? key,
    required this.userName,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 278.0,
          child: Row(
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(
              //   width: 90.0,
              // ),
              Spacer(),
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: TEXT_SMALL,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        //  SizedBox(
        //   height: MARGIN_MEDIUM,
        // ),
        //  Text(
        //   "Paris",
        //   style: TextStyle(
        //     fontSize: TEXT_SMALL,
        //     color: Colors.grey,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
      ],
    );
  }
}
