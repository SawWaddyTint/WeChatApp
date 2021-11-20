// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APP_THEME_COLOR,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Center(
            child: Text(
              "Contacts",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage("assets/add-contact.png"),
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
                color: CONTACTS_COMMON_COLOR,
              ),
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    // color: Color.fromRGBO(176, 176, 181, 1.0),
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          // color: Color.fromRGBO(176, 176, 181, 1.0),
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(color: CONTACTS_COMMON_COLOR, height: 1.5),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1.0,
                          color: CONTACTS_COMMON_COLOR,
                        ),
                      ),
                      // color: Colors.red,
                    ),
                    height: 110.0,
                    width: 90.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ImageIcon(AssetImage("assets/add-contact.png"),
                            color: Color.fromRGBO(123, 123, 123, 1.0)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Text(
                              "New    Friends",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Color.fromRGBO(123, 123, 123, 1.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1.0,
                          color: CONTACTS_COMMON_COLOR,
                        ),
                      ),
                      // color: Colors.red,
                    ),
                    height: 110.0,
                    width: 90.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ImageIcon(AssetImage("assets/group-chat.png"),
                            color: Color.fromRGBO(123, 123, 123, 1.0)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Text(
                              "Group    Chats",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Color.fromRGBO(123, 123, 123, 1.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // width: 100.0,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1.0,
                          color: CONTACTS_COMMON_COLOR,
                        ),
                      ),
                      // color: Colors.red,
                    ),
                    height: 110.0,
                    width: 90.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ImageIcon(
                            AssetImage(
                              "assets/tag.png",
                            ),
                            size: 20.0,
                            color: Color.fromRGBO(123, 123, 123, 1.0)),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Center(
                            child: Text(
                              "Tags",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Color.fromRGBO(123, 123, 123, 1.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // width: 100.0,
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1.0,
                          color: CONTACTS_COMMON_COLOR,
                        ),
                      ),
                      // color: Colors.red,
                    ),
                    height: 110.0,
                    width: 90.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ImageIcon(AssetImage("assets/account.png"),
                            color: Color.fromRGBO(123, 123, 123, 1.0)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Text(
                              "Offical    Accounts",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Color.fromRGBO(123, 123, 123, 1.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // width: 100.0,
                  ),
                ],
              )
            ],
          ),
          Container(color: CONTACTS_COMMON_COLOR, height: 6),
          // ListView.builder(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.vertical,
          //   itemBuilder: (context, index) {
          //     return StickyHeader(
          //       header: Container(
          //         height: 50.0,
          //         color: CONTACTS_COMMON_COLOR,
          //         padding: EdgeInsets.symmetric(horizontal: 16.0),
          //         alignment: Alignment.centerLeft,
          //         child: Text(
          //           'Header #$index',
          //           style: const TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       content: Container(
          //         child: Image.network(
          //             "https://ix-www.imgix.net/hp/snowshoe.jpg?q=70&w=1800&auto=compress%2Cenhance&fm=jpeg",
          //             fit: BoxFit.cover,
          //             width: double.infinity,
          //             height: 200.0),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
