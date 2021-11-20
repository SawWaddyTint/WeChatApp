import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/moments_page.dart';
import 'package:we_chat_app/resources/colors.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: APP_THEME_COLOR,
          title: Text(
            "Discover",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_outline_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          child: GestureDetector(
            child: ListTile(
              leading: Image.asset(
                'assets/moments.png',
                height: 30.0,
                width: 30.0,
              ),
              title: Text(
                "Discover",
                style: TextStyle(color: Colors.black),
              ),
              // trailing: IconButton(
              //   onPressed: () {
              //     _navigateToMomentsPage(context);
              //   },
              //   icon: Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.black,
              //     size: 20.0,
              //   ),
              // ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 20.0,
              ),
            ),
            onTap: () {
              _navigateToMomentsPage(context);
            },
          ),
        ));
  }

  _navigateToMomentsPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MomentsPage(),
      ),
    );
  }
}
