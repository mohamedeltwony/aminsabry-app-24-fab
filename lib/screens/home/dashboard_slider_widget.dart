import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/view_video/video_widget.dart';

import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/models/movie_episode/common_data_list_model.dart';
import 'package:streamit_flutter/screens/movie_episode/screens/movie_detail_screen.dart';

class DashboardSliderWidget extends StatefulWidget {
  final List<CommonDataListModel> mSliderList;

  DashboardSliderWidget({required this.mSliderList, super.key});

  @override
  State<DashboardSliderWidget> createState() => _DashboardSliderWidgetState();
}

class _DashboardSliderWidgetState extends State<DashboardSliderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    final Size cardSize = Size(width, appStore.hasInFullScreen ? context.height() : context.height() * 0.26);

    return Container(
      height: cardSize.height,
      width: cardSize.width,
      decoration: BoxDecoration(boxShadow: [], color: context.scaffoldBackgroundColor),
      child: PageView.builder(
        onPageChanged: (value) async {

        },
        itemCount: widget.mSliderList.validate().length,
        itemBuilder: (context, index) {
          CommonDataListModel slider = widget.mSliderList.validate()[index];
          return Container(
            key: UniqueKey(),
            width: context.width(),
            height: cardSize.height,
            decoration: BoxDecoration(boxShadow: [], color: context.scaffoldBackgroundColor),
            child: VideoWidget(
              videoURL: slider.trailerLink.validate(),
              watchedTime: '',
              videoType: slider.postType,
              videoURLType: slider.trailerLinkType.validate(),
              videoId: slider.id.validate(),
              thumbnailImage: slider.image.validate(),
              isTrailer: true,
              onTap: () async {
                appStore.setTrailerVideoPlayer(true);


                await MovieDetailScreen(movieData: slider).launch(context).then(
                  (value) {
                    setState(() {});
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}