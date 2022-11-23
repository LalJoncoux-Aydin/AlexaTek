import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alexatek/models/user.dart' as model;
import '../providers/user_provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late UserProvider userProvider;
  late model.User myUser;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setupUser();
    }
  }

  @override
  void setState(dynamic fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Feed"),
      )
    );
    /*final Size size = MediaQuery.of(context).size;
    double paddingGlobalHorizontal = 0;
    double paddingGlobalVertical = 0;

    if (size.width >= webScreenSize) {
      paddingGlobalHorizontal = 50;
      paddingGlobalVertical = 40;
    }

    if (_isLoadingPost == false || _isLoadingUser == false) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        appBar: size.width > webScreenSize
            ? null
            : AppBar(
                centerTitle: false,
                title: SvgPicture.asset(
                  'assets/instatek_logo.svg',
                  color: Theme.of(context).colorScheme.secondary,
                  height: 32,
                ),
                automaticallyImplyLeading: false,
              ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: paddingGlobalVertical, horizontal: paddingGlobalHorizontal),
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, int index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width > webScreenSize ? size.width * 0.3 : 0,
                    vertical: size.width > webScreenSize ? 10 : 0,
                  ),
                  child: PostCard(
                    displayPost: postList[index],
                    myUser: myUser,
                  ),
                ),
                itemCount: postList.length,
              ),
            ),
          ),
        ),
      );
    }*/
  }

  void updatePost(String uid) {}
}
