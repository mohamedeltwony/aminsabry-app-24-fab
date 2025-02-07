import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/cached_image_widget.dart';
import 'package:streamit_flutter/fragments/search_fragment.dart';
import 'package:streamit_flutter/screens/blog/screens/blog_list_screen.dart';
import 'package:streamit_flutter/screens/home/sub_home_fragment.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/screens/settings/screens/edit_profile_screen.dart';
import 'package:streamit_flutter/screens/auth/sign_in.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';
import 'package:streamit_flutter/utils/resources/images.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

class HomeFragment extends StatefulWidget {
  static String tag = '/HomeFragment';

  @override
  HomeFragmentState createState() => HomeFragmentState();
}

class HomeFragmentState extends State<HomeFragment> {
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: !appStore.hasInFullScreen
              ? AppBar(
                  centerTitle: false,
                  title: CachedImageWidget(url: ic_logo, height: 32, width: 120),
                  automaticallyImplyLeading: false,
                  actions: [
                    InkWell(
                      radius: 8,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        SearchFragment().launch(context);
                      },
                      child: Image.asset(ic_search, fit: BoxFit.contain, color: Colors.white, height: 20, width: 20),
                    ).paddingSymmetric(horizontal: 8, vertical: 16),
                    InkWell(
                      radius: 8,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        BlogListScreen().launch(context);
                      },
                      child: Image.asset(ic_blog, fit: BoxFit.contain, color: Colors.white, height: 20, width: 20),
                    ).paddingSymmetric(horizontal: 8, vertical: 16),
                    appStore.isLogging
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: CachedImageWidget(
                              url: appStore.userProfileImage.validate(),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 38,
                            ).onTap(() {
                              EditProfileScreen().launch(context);
                            }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
                          )
                        : CachedImageWidget(
                            url: add_user,
                            fit: BoxFit.fitWidth,
                            height: 18,
                            color: Colors.white,
                          ).paddingAll(12).onTap(
                            () {
                              SignInScreen().launch(context);
                            },
                            borderRadius: BorderRadius.circular(60),
                          ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size(context.width(), 45),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TabBar(
                        isScrollable: true,
                        indicatorPadding: EdgeInsets.only(left: 24, right: 24),
                        indicatorWeight: 0.0,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: boldTextStyle(size: ts_small.toInt()),
                        tabAlignment: TabAlignment.start,
                        indicatorColor: colorPrimary,
                        indicator: TabIndicator(),
                        onTap: (i) {
                          index = i;
                          setState(() {});

                          if (index == 0) {
                            LiveStream().emit(RefreshHome);
                          }
                        },
                        unselectedLabelStyle: secondaryTextStyle(size: ts_small.toInt()),
                        unselectedLabelColor: Theme.of(context).textTheme.titleLarge!.color,
                        labelColor: colorPrimary,
                        labelPadding: EdgeInsets.only(left: spacing_large, right: spacing_large),
                        tabs: [
                          Tab(child: Text(language!.home)),
                          Tab(child: Text(language!.movies)),
                          Tab(child: Text(language!.tVShows)),
                          Tab(child: Text(language!.videos)),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          body: TabBarView(
            children: <Widget>[
              SubHomeFragment(type: dashboardTypeHome),
              SubHomeFragment(type: dashboardTypeMovie),
              SubHomeFragment(type: dashboardTypeTVShow),
              SubHomeFragment(type: dashboardTypeVideo),
            ],
          ),
        ),
      ),
    );
  }
}
