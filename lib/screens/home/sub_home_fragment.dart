import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:streamit_flutter/components/loader_widget.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/models/dashboard_response.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/home/dashboard_slider_widget.dart';
import 'package:streamit_flutter/components/item_horizontal_list.dart';
import 'package:streamit_flutter/screens/home/view_all_movies_screen.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/cached_data.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/constants.dart';

import '../../components/view_video/youtube_player_widget.dart';

class SubHomeFragment extends StatefulWidget {
  static String tag = '/SubHomeFragment';
  final String? type;

  SubHomeFragment({this.type});

  @override
  SubHomeFragmentState createState() => SubHomeFragmentState();
}

class SubHomeFragmentState extends State<SubHomeFragment> with AutomaticKeepAliveClientMixin {
  late Future<DashboardResponse> future;

  @override
  void initState() {
    ScreenProtector.preventScreenshotOn();
    init();
    super.initState();
    LiveStream().on(RefreshHome, (p0) {
      future = getDashboardData({}, type: widget.type.validate(value: dashboardTypeHome));
      setState(() {});
    });
  }

  Future<void> init() async {
    future = getDashboardData({}, type: widget.type.validate(value: dashboardTypeHome)).then((v) {
      DashboardCachedData.storeData(dashboardTypeKey: widget.type.validate(), data: v.toJson());
      setState(() {});
      return v;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
    LiveStream().dispose(RefreshHome);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: () async {
        init();
        await 2.seconds.delay;
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: FutureBuilder<DashboardResponse>(
            initialData: DashboardCachedData.getData(dashboardTypeKey: widget.type.validate()),
            future: future,
            builder: (_, snap) {
              if (snap.hasData) {
                if (snap.data!.banner.validate().isEmpty && snap.data!.sliders.validate().isEmpty && snap.data!.continueWatch.validate().isEmpty) {
                  return NoDataWidget(
                    imageWidget: noDataImage(),
                    title: '${language!.no} ${widget.type.validate() == 'home' ? '${language!.content}' : widget.type.validate()} ${language!.found}',
                    subTitle: '${language!.the} ${widget.type.validate() == 'home' ? '${language!.content}' : widget.type.validate()} ${language!.hasNotYetBeenAdded}',
                  );
                }

                if (snap.data!.continueWatch.validate().isNotEmpty) {
                  getContinueWatchList();
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (snap.data!.banner.validate().isNotEmpty)
                        DashboardSliderWidget(
                          mSliderList: snap.data!.banner.validate(),
                          key: ValueKey(widget.type),
                        ),
                      if (snap.data!.continueWatch.validate().isNotEmpty && appStore.isLogging)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingWidViewAll(
                              context,
                              language!.continueWatching,
                              showViewMore: false,
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                              callback: () async {
                                getContinueWatchList();
                                LiveStream().emit(PauseVideo);
                              },
                            ).paddingSymmetric(horizontal: 16, vertical: 16),
                            ItemHorizontalList(
                              snap.data!.continueWatch.validate(),
                              isContinueWatch: true,
                              isLandscape: true,
                              onListEmpty: () {
                                snap.data!.continueWatch = [];
                                setState(() {});
                              },
                            ),
                          ],
                        ).visible(!appStore.hasInFullScreen),
                      Column(
                        children: snap.data!.sliders.validate().map((e) {
                          if (e.data.validate().isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headingWidViewAll(
                                  context,
                                  e.title.validate(),
                                  callback: () async {
                                    LiveStream().emit(PauseVideo);
                                    await ViewAllMoviesScreen(snap.data!.sliders!.indexOf(e), e.type.toString(), e.title.validate()).launch(context);
                                  },
                                  showViewMore: e.viewAll.validate(),
                                ),
                                ItemHorizontalList(
                                  e.data.validate(),
                                  isTop10: e.type.validate() == 'top_ten',
                                  isContinueWatch: false,
                                ),
                              ],
                            );
                          } else {
                            return Offstage();
                          }
                        }).toList(),
                      ).visible(!appStore.hasInFullScreen),
                    ],
                  ),
                );
              } else {
                return snapWidgetHelper(
                  snap,
                  loadingWidget: LoaderWidget(),
                  errorWidget: NoDataWidget(
                    imageWidget: noDataImage(),
                    title: language!.somethingWentWrong,
                  ),
                ).center();
              }
            },
          ).makeRefreshable,
        ),
      ),
    );
  }
}
