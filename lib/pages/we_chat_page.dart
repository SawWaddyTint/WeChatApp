import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/chat_page.dart';
import 'package:we_chat_app/resources/colors.dart';

// import 'package:we_chat_app/pages/chat_page.dart';
import 'package:we_chat_app/resources/dimens.dart';

class WeChatPage extends StatelessWidget {
  const WeChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: APP_THEME_COLOR,
        centerTitle: true,
        title: const Text("WeChat"),
        actions: const [AddButtonSession()],
      ),
      body: Container(
        // color: Colors.black12,
        child: Column(
          children: [
            // SearchBarView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: GestureDetector(
                  child: ListTile(
                    leading: Container(
                      // margin: const EdgeInsets.only(bottom: 6.0),
                      height: 85.0,
                      width: 85.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://miro.medium.com/max/395/1*n2DxqTwROXZmkLUjTD4uXQ.jpeg'),
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.green),
                      // child: Image.network(
                      //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmDZqFk24mo_-qNzSjjW_04GrisbLgfqlZMw&usqp=CAU",
                      // ),
                    ),
                    title: Text("Amie Deane"),
                    subtitle: Text(
                      "I'm stuck with that.Can't believe it.Do we have to do all that stuff later",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        "9:52 AM",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  onTap: () {
                    _navigateToChatPage(context);
                  },
                ),
              ),
            ),
            Container(
              color: CONTACTS_COMMON_COLOR,
              height: 1,
            )
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(5.0),
            //   child: Container(
            //     height: 100.0,
            //     margin: const EdgeInsets.only(
            //         bottom: 1.0), //Same as `blurRadius` i guess
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5.0),
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey,
            //           offset: Offset(0.0, 1.0), //(x,y)
            //           blurRadius: 1.0,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _navigateToChatPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(),
      ),
    );
  }
}

// class SearchBarView extends StatelessWidget {
//   const SearchBarView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30.0,
//       margin: EdgeInsets.symmetric(
//           horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
//       //color: Colors.white70,
//       decoration: BoxDecoration(
//           color: Colors.white70, borderRadius: BorderRadius.circular(4.0)),
//       child: Row(
//         children: [
//           Icon(
//             Icons.search,
//             size: MARGIN_MEDIUM_2,
//             color: Colors.black54,
//           ),
//           Text(
//             "Search",
//             style: TextStyle(
//                 fontSize: TEXT_REGULAR_2X,
//                 fontWeight: FontWeight.w300,
//                 color: Colors.black54),
//           )
//         ],
//       ),
//     );
//   }
// }

class AddButtonSession extends StatelessWidget {
  const AddButtonSession({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
      child: Icon(Icons.add),
    );
  }
}
