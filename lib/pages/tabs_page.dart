import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/contacts_page.dart';
import 'package:we_chat_app/pages/discover_page.dart';
import 'package:we_chat_app/pages/me_page.dart';
import 'package:we_chat_app/pages/we_chat_page.dart';
import 'package:we_chat_app/resources/colors.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

int currentIndex = 0;
final List<Widget> _children = [
  WeChatPage(),
  ContactsPage(),
  DiscoverPage(),
  MePage(),
  //  PlaceholderWidget(Colors.green)
];

class _TabsPageState extends State<TabsPage> {
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _children[currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: APP_THEME_COLOR,
          onTap: onTabTapped, // new
          currentIndex: currentIndex, // new
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          items: [
            new BottomNavigationBarItem(
              icon: currentIndex == 0
                  ? ImageIcon(
                      AssetImage("assets/wechatActive.png"),
                    )
                  : ImageIcon(
                      AssetImage("assets/wechat.png"),
                    ),
              label: 'WeChat',
            ),
            new BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? ImageIcon(
                      AssetImage("assets/contactsActive.png"),
                    )
                  : ImageIcon(
                      AssetImage("assets/contacts.png"),
                    ),
              label: 'Contacts',
            ),
            new BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? ImageIcon(
                      AssetImage("assets/discoverActive.png"),
                    )
                  : ImageIcon(
                      AssetImage("assets/discover.png"),
                    ),
              label: 'Discover',
            ),
            new BottomNavigationBarItem(
                icon: currentIndex == 3
                    ? ImageIcon(
                        AssetImage("assets/meActive.png"),
                      )
                    : ImageIcon(
                        AssetImage("assets/me.png"),
                      ),
                label: 'Me'),
          ],
        ),
      ),
    );
  }
}
