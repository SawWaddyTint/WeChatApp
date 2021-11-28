import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/blocs/chat_bloc.dart';
import 'package:we_chat_app/data/vos/chat_vo.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:file_picker/file_picker.dart';
import 'package:we_chat_app/viewitems/video_view.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController? text;
    ScrollController _scrollController = new ScrollController();
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(),
      child: Selector<ChatBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leadingWidth: 120.0,
                elevation: 0,
                backgroundColor: APP_THEME_COLOR,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20.0,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "WeChat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  "Amie Deane",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55.0),
                    child: Consumer<ChatBloc>(
                      builder: (context, bloc, child) {
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: bloc.chatList?.length,
                            itemBuilder: (context, index) {
                              return Align(
                                  alignment: Alignment.bottomRight,
                                  child: ChatView(bloc.chatList?[index]));
                            });
                      },
                    ),
                  ),
                  Selector<ChatBloc, bool>(
                    selector: (context, bloc) => bloc.showOptions,
                    builder: (context, showOptions, child) {
                      return Visibility(
                        visible: !showOptions,
                        child: Selector<ChatBloc, File?>(
                          selector: (context, bloc) => bloc.filePath,
                          builder: (context, file, child) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ChatFooterView(
                                () => _showOptions(context),
                                text ?? TextEditingController(),
                                _scrollController,
                                file: file,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Selector<ChatBloc, bool>(
                    selector: (context, bloc) => bloc.showOptions,
                    builder: (context, showOptions, child) {
                      return Visibility(
                        visible: showOptions,
                        child: Selector<ChatBloc, File?>(
                          selector: (context, bloc) => bloc.filePath,
                          builder: (context, file, child) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ChatFooterViewWithOptions(
                                () => _showOptions(context),
                                text ?? TextEditingController(),
                                _scrollController,
                                file: file,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingView(),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _showOptions(BuildContext context) {
    ChatBloc bloc = Provider.of<ChatBloc>(context, listen: false);
    bloc.showOpt();
  }
}

_chooseFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    String? fileName = result.files.first.name;
    String? filePath = result.files.first.path;
    if (filePath != null) {
      // bloc.fileToUint8List(File(image.path));
      ChatBloc bloc = Provider.of<ChatBloc>(context, listen: false);
      bloc.uploadFile(File(filePath), fileName);
    }
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: const Center(
          child: SizedBox(
            width: MARGIN_XXLARGE,
            height: MARGIN_XXLARGE,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [Colors.white],
              strokeWidth: 2,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: APP_THEME_COLOR,
            ),
          ),
        ));
  }
}

class ChatView extends StatelessWidget {
  final ChatVO? chat;

  ChatView(this.chat);

  @override
  Widget build(BuildContext context) {
    return (chat?.type == "text")
        ? Container(
            // width: 100.0,
            margin: EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
            padding: EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color.fromRGBO(230, 230, 230, 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_SMALL, vertical: MARGIN_SMALL),
              child: Text(
                chat?.text ?? "",
                style:
                    TextStyle(color: Colors.black, fontSize: TEXT_REGULAR_2X),
              ),
            ),
          )
        : (chat?.type == "image")
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: CONTACTS_COMMON_COLOR,
                  child: Column(
                    children: [
                      Visibility(
                        visible: chat?.textWithFile ?? false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            chat?.text ?? "",
                            style: TextStyle(
                                color: Colors.black, fontSize: TEXT_REGULAR_2X),
                          ),
                        ),
                      ),
                      Container(
                        // width: 100.0,
                        width: 300,
                        height: 300,
                        margin: EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                        // padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromRGBO(230, 230, 230, 1.0),
                        ),
                        child: Image.network(chat?.imageUrl ?? "",
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                color: CONTACTS_COMMON_COLOR,
                child: Column(
                  children: [
                    Visibility(
                      visible: chat?.textWithFile ?? false,
                      child: Text(chat?.text ?? ""),
                    ),
                    Container(
                      // width: 100.0,
                      width: 300,
                      height: 300,
                      margin: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color.fromRGBO(230, 230, 230, 1.0),
                      ),
                      child: VideoView(
                        videoPlayerController:
                            VideoPlayerController.network(chat?.videoUrl ?? ""),
                      ),
                    ),
                  ],
                ),
              );
  }
}

class ChatFooterView extends StatelessWidget {
  final Function sendMessage;
  final TextEditingController controller;
  final ScrollController _scrollController;
  final File? file;

  ChatFooterView(this.sendMessage(), this.controller, this._scrollController,
      {this.file});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: CONTACTS_COMMON_COLOR,
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_SMALL, vertical: MARGIN_SMALL),
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: Consumer<ChatBloc>(builder: (context, bloc, child) {
              return Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    AssetImage("assets/mic.png"),
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: MARGIN_SMALL,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.28,
                          //height: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Consumer<ChatBloc>(
                              builder: (context, bloc, child) {
                            return TextFormField(
                              controller: bloc.controller,
                              cursorColor: Colors.grey,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                              ),
                              onChanged: (text) {
                                bloc.onTextChanged(text, controller);
                              },
                            );
                          }),
                        ),
                        Positioned(
                          right: 5.0,
                          bottom: 10.0,
                          child: Icon(
                            Icons.emoji_emotions,
                            color: Color.fromRGBO(155, 155, 155, 1.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: MARGIN_SMALL,
                  ),
                  Visibility(
                    visible: bloc.hasData,
                    child: GestureDetector(
                      child: Icon(
                        Icons.send,
                      ),
                      onTap: () {
                        _sendMessage(context, _scrollController);
                      },
                    ),
                  ),
                  Visibility(
                    visible: !bloc.hasData,
                    child: GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.grey,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          (file != null)
              ? Consumer<ChatBloc>(builder: (context, bloc, child) {
                  return Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //height: 40.0,
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(10.0)),
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: (!bloc.isVideo)
                              ? Image.file(
                                  file ?? File(""),
                                  fit: BoxFit.cover,
                                )
                              : VideoView(
                                  videoPlayerController:
                                      VideoPlayerController.file(
                                    file ?? File(""),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                })
              : Container(),
        ],
      ),
    );
  }
}

class ChatFooterViewWithOptions extends StatelessWidget {
  final Function sendMessage;
  final TextEditingController controller;
  final ScrollController _scrollController;
  final File? file;

  ChatFooterViewWithOptions(
      this.sendMessage(), this.controller, this._scrollController,
      {this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: CONTACTS_COMMON_COLOR,
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_SMALL, vertical: MARGIN_SMALL),
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: Consumer<ChatBloc>(builder: (context, bloc, child) {
            return Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage("assets/mic.png"),
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: MARGIN_SMALL,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.28,
                        //height: 40.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child:
                            Consumer<ChatBloc>(builder: (context, bloc, child) {
                          return TextFormField(
                            controller: bloc.controller,
                            cursorColor: Colors.grey,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (text) {
                              bloc.onTextChanged(text, controller);
                            },
                          );
                        }),
                      ),
                      Positioned(
                        right: 5.0,
                        bottom: 10.0,
                        child: Icon(
                          Icons.emoji_emotions,
                          color: Color.fromRGBO(155, 155, 155, 1.0),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: MARGIN_SMALL,
                ),
                Visibility(
                  visible: bloc.hasData,
                  child: GestureDetector(
                    child: Icon(
                      Icons.send,
                    ),
                    onTap: () {
                      _sendMessage(context, _scrollController);
                    },
                  ),
                ),
                Visibility(
                  visible: !bloc.showOptions,
                  child: GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
                Visibility(
                  visible: bloc.showOptions && !bloc.hasData,
                  child: GestureDetector(
                    onTap: () {
                      closeOpt(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 26,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Selector<ChatBloc, bool>(
          selector: (context, bloc) => bloc.showOptions,
          builder: (context, showOptions, child) {
            return Visibility(
              visible: showOptions,
              child: Container(
                  color: Color.fromRGBO(242, 242, 242, 1.0),
                  height: 185,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          OptionsView(Icons.photo_outlined, "Photos",
                              () => _chooseFile(context)),
                          OptionsView(Icons.money, "Luck Money",
                              () => _chooseFile(context)),
                        ],
                      ),
                      Column(
                        children: [
                          OptionsView(Icons.camera_alt_outlined, "Camera",
                              () => _chooseFile(context)),
                          OptionsView(Icons.compare_arrows_outlined, "Transfer",
                              () => _chooseFile(context)),
                        ],
                      ),
                      Column(
                        children: [
                          OptionsView(Icons.remove_red_eye_outlined, "Sight",
                              () => _chooseFile(context)),
                          OptionsView(Icons.favorite_outline_outlined,
                              "Favourites", () => _chooseFile(context)),
                        ],
                      ),
                      Column(
                        children: [
                          OptionsView(Icons.videocam_outlined, "Video Call",
                              () => _chooseFile(context)),
                          OptionsView(Icons.pin_drop_outlined, "Location",
                              () => _chooseFile(context)),
                        ],
                      ),
                    ],
                  )),
            );
          },
        ),
        // Selector<ChatBloc, File?>(
        //   selector: (context, bloc) => bloc.filePath,
        //   builder: (context, file, child) {
        //     return (file != null)

        //   },
        // ),
      ],
    );
  }
}

class OptionsView extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Function onTap;
  OptionsView(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Icon(
              icon,
              color: Colors.grey,
              size: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(text ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}

closeOpt(BuildContext context) {
  ChatBloc bloc = Provider.of<ChatBloc>(context, listen: false);
  bloc.closeOpt();
}

_sendMessage(BuildContext context, ScrollController _scrollController) {
  ChatBloc bloc = Provider.of<ChatBloc>(context, listen: false);
  bloc.sendMessage().then((value) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      ));
}

class messageTextFieldViewSession extends StatelessWidget {
  const messageTextFieldViewSession({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
}
