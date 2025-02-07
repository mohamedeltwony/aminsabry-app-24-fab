import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:screen_protector/screen_protector.dart';

import 'package:streamit_flutter/components/live_tv_slider_component.dart';

import '../components/item_horizontal_list.dart';
import '../components/loader_widget.dart';
import '../main.dart';
import '../models/dashboard_response.dart';
import '../network/rest_apis.dart';

import '../screens/live_tv/screens/view_all_live_tv_channels.dart';
import '../utils/app_theme.dart';
import '../utils/app_widgets.dart';
import '../utils/common.dart';
import '../utils/constants.dart';

class LiveFragment extends StatefulWidget {
  static String tag = '/Live Fragment';

  const LiveFragment({Key? key}) : super(key: key);

  @override
  _LiveFragmentState createState() => _LiveFragmentState();
}

class _LiveFragmentState extends State<LiveFragment> {
  ScrollController controller = ScrollController();
  PageController sliderController = PageController();

  int currentSliderIndex = 0;

  late Future<DashboardResponse> future;

  @override
  void initState() {
    ScreenProtector.preventScreenshotOn();
    init();
    super.initState();
  }

  Future<void> init() async {
    appStore.setLoading(true);
    future = getDashboardData({}, type: dashboardTypeLive).then((v) {
      setState(() {});
      appStore.setLoading(false);
      return v;
    }).catchError((e) {
      appStore.setLoading(false);
      throw e;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    appStore.setLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        init();
        return await 2.seconds.delay;
      },
      child: Scaffold(
        backgroundColor: CupertinoColors.black,
        appBar: AppBar(
          title: Text('Live TV', style: boldTextStyle(color: Colors.white, size: 20)),
          automaticallyImplyLeading: false,
          centerTitle: false,
          systemOverlayStyle: defaultSystemUiOverlayStyle(
            context,
            color: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: Stack(
          children: [
            SnapHelperWidget(
              future: future,
              loadingWidget: Offstage(),
              onSuccess: (data) {
                return CustomScrollView(
                  controller: controller,
                  shrinkWrap: true,
                  slivers: <Widget>[
                    Theme(
                      data: AppTheme.darkTheme,
                      child: SliverAppBar(
                        systemOverlayStyle: defaultSystemUiOverlayStyle(context),
                        expandedHeight: context.height() * 0.40,
                        backgroundColor: CupertinoColors.black,
                        flexibleSpace: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FlexibleSpaceBar(
                              background: Stack(
                                children: [
                                  PageView.builder(
                                    itemBuilder: (context, index) {
                                      return LiveTvSliderComponent(sliderData: data.banner.validate()[index]);
                                    },
                                    controller: sliderController,
                                    itemCount: data.banner.validate().length,
                                    allowImplicitScrolling: true,
                                    pageSnapping: true,
                                    onPageChanged: (page) {
                                      currentSliderIndex = page;
                                      sliderController.animateToPage(page, duration: Duration(milliseconds: 1000), curve: Curves.ease);
                                      setState(() {});
                                    },
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        data.banner.validate().length,
                                        (index) {
                                          return InkWell(
                                            onTap: () {
                                              currentSliderIndex = index;
                                              sliderController.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.ease);
                                              setState(() {});
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.all(4),
                                              padding: EdgeInsets.all(currentSliderIndex == index ? 5 : 4),
                                              decoration: boxDecorationDefault(
                                                shape: BoxShape.circle,
                                                color: currentSliderIndex == index ? Colors.white : Colors.white54,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Column(
                          children: data.sliders.validate().map((e) {
                            if (e.data.validate().isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headingWidViewAll(
                                    context,
                                    e.title.validate(),
                                    callback: () async {
                                      ViewAllLiveTvChannels(
                                        categoryTitle: e.title.validate(),
                                        sliderIndex: data.sliders.validate().indexOf(e),
                                      ).launch(context);
                                    },
                                    showViewMore: e.viewAll.validate(),
                                  ),
                                  ItemHorizontalList(
                                    e.data.validate(),
                                    isLandscape: true,
                                    isLiveTv: true,
                                  ),
                                ],
                              );
                            } else {
                              return Offstage();
                            }
                          }).toList(),
                        ).visible(!appStore.hasInFullScreen),
                      ),
                    )
                  ],
                );
              },
            ),
            Observer(
              builder: (_) => LoaderWidget().visible(appStore.isLoading).center(),
            ),
          ],
        ),
      ),
    );
  }
}
