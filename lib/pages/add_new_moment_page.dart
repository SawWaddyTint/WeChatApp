// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/blocs/add_new_moment_bloc.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/video_view.dart';
import 'package:we_chat_app/widgets/profile_image_view.dart';

class AddNewMomentPage extends StatelessWidget {
  final int? newsFeedId;

  AddNewMomentPage({
    Key? key,
    this.newsFeedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewMomentBloc(newsFeedId: newsFeedId),
      child: Selector<AddNewMomentBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: false,
                title: Selector<AddNewMomentBloc, bool>(
                  selector: (context, bloc) => bloc.isInEditMode,
                  builder: (context, isInEditMode, child) => Container(
                    margin: EdgeInsets.only(
                      left: MARGIN_MEDIUM,
                    ),
                    child: Text(
                      isInEditMode ? "Edit Moment" : "Create Moment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: TEXT_HEADING_1X,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  // ignore: prefer_const_constructors
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: MARGIN_XLARGE,
                  ),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(
                  top: MARGIN_XLARGE,
                ),
                padding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileImageAndNameView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      AddNewPostTextFieldView(),
                      SizedBox(
                        height: MARGIN_MEDIUM,
                      ),
                      PostDescriptionErrorView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      PostImageView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      PostButtonView(),
                      SizedBox(
                        height: MARGIN_MEDIUM,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black12,
                child: Center(
                  child: LoadingView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostDescriptionErrorView extends StatelessWidget {
  PostDescriptionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => Visibility(
        visible: bloc.isAddNewPostError,
        child: Text(
          "Post should not be empty",
          style: TextStyle(
            color: Colors.red,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class PostButtonView extends StatelessWidget {
  PostButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => GestureDetector(
        onTap: () {
          bloc.onTapAddNewPost().then((value) {
            Navigator.pop(context);
          });
        },
        child: Container(
          width: double.infinity,
          height: MARGIN_XXLARGE,
          decoration: BoxDecoration(
            color: APP_THEME_COLOR,
            borderRadius: BorderRadius.circular(
              MARGIN_LARGE,
            ),
          ),
          child: Center(
            child: Text(
              "POST",
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  ProfileImageAndNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          ProfileImageView(
            profileImage: bloc.profilePicture,
          ),
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          Text(
            bloc.userName,
            style: TextStyle(
              fontSize: TEXT_REGULAR_2X,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AddNewPostTextFieldView extends StatelessWidget {
  AddNewPostTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: ADD_NEW_POST_TEXTFIELD_HEIGHT,
        child: TextField(
          enableInteractiveSelection: true,
          maxLines: 24,
          controller: TextEditingController(text: bloc.newPostDescription),
          onChanged: (text) {
            bloc.onNewPostTextChanged(text);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                MARGIN_MEDIUM,
              ),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            hintText: "What's on your mind?",
          ),
        ),
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => Container(
        padding: EdgeInsets.all(MARGIN_MEDIUM),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            border: Border.all(color: Colors.black, width: 1)),
        child: Stack(children: [
          // show network image
          GestureDetector(
            child: Visibility(
              visible: bloc.showNetworkImg,
              child: SizedBox(
                height: 300,
                child: Image.network(
                  (bloc.imageUrl == "")
                      ? "https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png"
                      : bloc.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              _chooseFile(context);
            },
          ),
          //show local image or gif
          GestureDetector(
            child: Visibility(
              visible: !bloc.showNetworkImg && !bloc.isVideo,
              child: SizedBox(
                height: 300,
                child: Image.file(
                  bloc.chosenImageFile ?? File(""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              _chooseFile(context);
            },
          ),
          GestureDetector(
            child: Visibility(
                visible: !bloc.showNetworkImg && bloc.isVideo,
                child: VideoView(bloc.videoFile ?? File(""), "")),
            onTap: () {
              _chooseFile(context);
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: (bloc.chosenImageFile != null || bloc.imageUrl != ""),
              child: GestureDetector(
                  onTap: () {
                    bloc.onTapDeleteImage();
                  },
                  child: Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}

_chooseFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    Uint8List? fileBytes = result.files.first.bytes;
    String? fileName = result.files.first.name;
    String? filePath = result.files.first.path;
    if (filePath != null) {
      // bloc.fileToUint8List(File(image.path));
      AddNewMomentBloc bloc =
          Provider.of<AddNewMomentBloc>(context, listen: false);
      bloc.onImageChosen(File(filePath), fileName);
    }
  }
}

class LoadingView extends StatelessWidget {
  LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Center(
          child: SizedBox(
            width: MARGIN_XXLARGE,
            height: MARGIN_XXLARGE,
            child: LoadingIndicator(
              indicatorType: Indicator.audioEqualizer,
              colors: [Colors.white],
              strokeWidth: 2,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.black,
            ),
          ),
        ));
  }
}
