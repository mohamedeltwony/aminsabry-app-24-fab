import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/cached_image_widget.dart';
import 'package:streamit_flutter/models/movie_episode/common_data_list_model.dart';
import 'package:streamit_flutter/screens/live_tv/components/live_card.dart';
import 'package:streamit_flutter/screens/live_tv/screens/live_channel_detail_screen.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';

import '../models/live_tv/live_channel_detail_model.dart';

class LiveTvSliderComponent extends StatelessWidget {
  final CommonDataListModel sliderData;

  const LiveTvSliderComponent({Key? key, required this.sliderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedImageWidget(
          url: sliderData.image.validate(),
          height: context.height() * 0.44,
          width: context.width(),
          fit: BoxFit.cover,
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            height: context.height() * 0.40,
            width: context.width(),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  black.withValues(alpha: 0.8),
                  black.withValues(alpha: 0.5),
                  black.withValues(alpha: 0.9),
                  black.withValues(alpha: 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(sliderData.title.validate(), style: boldTextStyle(size: 22)),
              8.height,
              AppButton(
                width: context.width() / 2,
                padding: EdgeInsets.zero,
                color: cardColor,
                onTap: () {
                  ChannelData channelDetailModel = ChannelData(
                    details: Details(
                      id: sliderData.id.validate(),
                      title: sliderData.title.validate(),
                      image: sliderData.image.validate(),
                      streamType: sliderData.channelStreamType.validate(),
                      url: sliderData.trailerLink.validate(),
                      description: sliderData.description.validate(),
                      postType: PostType.LIVE_TV,
                    ),
                    recommendedChannels: [],
                  );
                  log(sliderData.toJson());
                  LiveChannelDetailScreen(channelData: channelDetailModel).launch(context);
                },
                child: Wrap(
                  spacing: 6,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    Text('Play Now', style: primaryTextStyle()),
                  ],
                ),
              ),
              16.height,
            ],
          ).paddingOnly(bottom: 28),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: LiveTagComponent(),
        )
      ],
    );
  }
}
