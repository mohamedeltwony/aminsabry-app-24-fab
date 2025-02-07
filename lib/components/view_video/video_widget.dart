import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/view_video/video_player_widget.dart';
import 'package:streamit_flutter/components/view_video/webview_content_widget.dart';
import 'package:streamit_flutter/components/view_video/youtube_player_widget.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/extentions/string_extentions.dart';

import '../../main.dart';
import '../cached_image_widget.dart';

class VideoWidget extends StatelessWidget {
  final String videoURL;
  final String watchedTime;
  final PostType videoType;
  final String videoURLType;
  final int videoId;
  final String thumbnailImage;
  final VoidCallback? onTap;

  final bool isTrailer;

  VideoWidget({
    required this.videoURL,
    required this.watchedTime,
    required this.videoType,
    required this.videoURLType,
    required this.videoId,
    this.onTap,
    required this.thumbnailImage,
    required this.isTrailer,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    final Size cardSize = Size(width, appStore.hasInFullScreen ? context.height() : context.height() * 0.3);
    return Container(
      width: cardSize.width,
      height: cardSize.height,
      decoration: boxDecorationDefault(
        color: context.cardColor,
        boxShadow: [],
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            context.scaffoldBackgroundColor.withValues(alpha: 0.3),
          ],
          stops: [0.3, 1.0],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.mirror,
        ),
      ),
      child: videoURL.validate().isEmpty || videoURLType.isEmpty
          ? CachedImageWidget(
              url: thumbnailImage.validate(),
              width: cardSize.width,
              height: cardSize.height,
              fit: BoxFit.cover,
            ).onTap(
              () {
                onTap?.call();
              },
            )
          : videoURLType.toLowerCase() == VideoType.typeYoutube
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    onTap?.call();
                  },
                  child: YoutubePlayerWidget(
                    // key: UniqueKey(),
                    videoURL: videoURL.validate(),
                    watchedTime: watchedTime,
                    videoType: videoType,
                    videoURLType: videoURLType,
                    videoId: videoId,
                    videoThumbnailImage: thumbnailImage,
                    isTrailer: isTrailer,
                  ),
                )
              : videoURLType.toLowerCase() == VideoType.typeVimeo
                  ? InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        onTap?.call();
                      },
                      child: WebViewContentWidget(
                        uri: Uri.parse('https://player.vimeo.com/video/${videoURL.getVimeoVideoId}'),
                        autoPlayVideo: isTrailer,
                      ),
                    )
                  : InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        onTap?.call();
                      },
                      child: VideoPlayerWidget(
                        videoURL: videoURL.validate(),
                        watchedTime: watchedTime,
                        videoType: videoType,
                        videoURLType: videoURLType,
                        videoId: videoId,
                        videoThumbnailImage: thumbnailImage,
                        isTrailer: isTrailer,
                      ),
                    ),
    );
  }
}