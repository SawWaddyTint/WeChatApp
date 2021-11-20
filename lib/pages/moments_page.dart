// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/add_new_moment_bloc.dart';
import 'package:we_chat_app/blocs/moments_bloc.dart';
import 'package:we_chat_app/network/real_time_database_data_agent_impl.dart';
import 'package:we_chat_app/pages/add_new_moment_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/viewitems/moment_item_view.dart';
import 'package:we_chat_app/widgets/profile_image_view.dart';

class MomentsPage extends StatelessWidget {
  const MomentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MomentsBloc(),
      child: Scaffold(
        backgroundColor: MOMENTS_BG_COLOR,
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
                  "Discover",
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
            "Moments",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: APP_THEME_COLOR,
          onPressed: () {
            /// Navigate to Add New Post Page
            _navigateToAddNewMomentPage(context);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 300.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // background image and bottom contents
                    Column(
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          color: Colors.orange,
                          child: Image.network(
                            "https://images.template.net/wp-content/uploads/2014/11/Natural-Facebook-Cover-Photo.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 170.0,
                      right:
                          10.0, // (background container size) - (circle height / 2)
                      child: Text("Waddy"),
                    ),
                    Positioned(
                      top: 220.0,
                      right:
                          10.0, // (background container size) - (circle height / 2)
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Sunday,Nov 18,2021",
                            style: TextStyle(fontSize: 13.0),
                          ),
                          Text(
                            "23 new moments",
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ],
                      ),
                    ),

                    // Profile image
                    Positioned(
                      top: 150.0,
                      right:
                          200.0, // (background container size) - (circle height / 2)
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZxkSZZexYAuvoGPFlRyWsZ-XMhaYTDwzk9A&usqp=CAU'),
                            ),
                            shape: BoxShape.circle,
                            color: Colors.green),
                        // child: Image.network(
                        //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmDZqFk24mo_-qNzSjjW_04GrisbLgfqlZMw&usqp=CAU",
                        // ),
                      ),
                    )
                  ],
                ),
              ),
              Consumer<MomentsBloc>(
                builder: (context, bloc, child) => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  itemBuilder: (context, index) {
                    return MomentItemView(
                      mMoment: bloc.moment?[index],
                      onTapDelete: (newsFeedId) {
                        bloc.onTapDeletePost(newsFeedId);
                      },
                      onTapEdit: (newsFeedId) {
                        Future.delayed(const Duration(milliseconds: 1000))
                            .then((value) {
                          _navigateToEditPostPage(context, newsFeedId);
                        });
                      },
                      onTapLike: (moment) {
                        bloc.onTapLikePost(moment);
                      },
                    );
                  },
                  itemCount: bloc.moment?.length ?? 0,
                ),
              ),
              SizedBox(
                height: 40.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAddNewMomentPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNewMomentPage(),
      ),
    );
  }

  void _navigateToEditPostPage(BuildContext context, int newsFeedId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNewMomentPage(
          newsFeedId: newsFeedId,
        ),
      ),
    );
  }
}
