import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pod_player/pod_player.dart';
import 'package:streamit_flutter/utils/resources/extentions/string_extentions.dart';

import '../../main.dart';
import '../../network/rest_apis.dart';
import '../../utils/common.dart';
import '../../utils/constants.dart';
import '../../utils/resources/colors.dart';
import '../cached_image_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  final int videoId;
  final String videoURL;
  final String videoThumbnailImage;
  final String watchedTime;
  final PostType videoType;
  final String videoURLType;
  final bool isTrailer;
  final bool isFromDashboard;

  const VideoPlayerWidget({
    Key? key,
    required this.videoURL,
    required this.watchedTime,
    required this.videoType,
    required this.videoURLType,
    required this.videoId,
    this.videoThumbnailImage = '',
    this.isTrailer = true,
    this.isFromDashboard = false,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final PodPlayerController podPlayerController;
  bool isMute = false;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    podPlayerController = PodPlayerController(
      playVideoFrom: widget.videoURL.getPlatformVideo(),
      podPlayerConfig: PodPlayerConfig(
        autoPlay: widget.watchedTime.isEmpty,
        wakelockEnabled: true,
        isLooping: widget.isTrailer,
        forcedVideoFocus: true,
      ),
    );
    podPlayerController.initialise().then((_) {
      if (widget.isTrailer) {
        podPlayerController.mute();
        isMute = true;
      }
      if (widget.watchedTime.isNotEmpty && !widget.isTrailer && isFirstTime) {
        isFirstTime = false;
        podPlayerController.pause();
        resumeVideoDialog();
      }
      setState(() {});
    });
  }

  Future<void> saveWatchTime() async {
    saveVideoContinueWatch(
      postId: widget.videoId.validate().toInt(),
      watchedTotalTime: podPlayerController.videoPlayerValue!.duration.inSeconds,
      watchedTime: podPlayerController.videoPlayerValue!.position.inSeconds,
    ).then((value) {
      LiveStream().emit(RefreshHome);
      getContinueWatchList();
    }).catchError(onError);
  }

  void resumeVideoDialog() {
    int watchedSeconds = int.parse(widget.watchedTime);
    showResumeVideoDialog(
      context: context,
      resume: () async {
        podPlayerController.videoSeekForward(Duration(seconds: watchedSeconds));
        podPlayerController.play();
      },
      starOver: () {
        podPlayerController.videoSeekBackward(Duration(seconds: 0));
        podPlayerController.play();
      },
    );
  }

  @override
  void dispose() {
    if (appStore.isLogging && !widget.isTrailer && widget.videoType != PostType.LIVE_TV) saveWatchTime();
    podPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PodVideoPlayer(
          controller: podPlayerController,
          frameAspectRatio: 16 / 9,
          videoAspectRatio: 16 / 9,
          podPlayerLabels: PodPlayerLabels(),
          videoThumbnail: widget.videoThumbnailImage.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(widget.videoThumbnailImage),
                  fit: BoxFit.cover,
                )
              : null,
          onVideoError: () => CachedImageWidget(
            url: widget.videoThumbnailImage,
            width: context.width(),
            fit: BoxFit.cover,
          ),
          onLoading: (context) => Loader(),
          podProgressBarConfig: PodProgressBarConfig(
            playingBarColor: colorPrimary,
            circleHandlerColor: colorPrimary,
            height: 4,
            curveRadius: 8,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          ),
          onToggleFullScreen: (isFullScreen) async {
            if (isFullScreen)
              setOrientationLandscape();
            else
              setOrientationPortrait();
            return appStore.setToFullScreen(isFullScreen);
          },
        ),
        if (widget.videoType == PostType.LIVE_TV)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text("Live", style: boldTextStyle(size: 14, color: Colors.white)),
            ),
          ),
        if (!widget.isFromDashboard) const Positioned(left: 8, top: 8, child: BackButton()),
        if (widget.isTrailer && podPlayerController.isInitialised)
          Positioned(
            right: 8,
            bottom: 8,
            child: IconButton(
              onPressed: () {
                isMute = !isMute;
                isMute ? podPlayerController.mute() : podPlayerController.unMute();
                setState(() {});
              },
              icon: Icon(
                size: 18,
                isMute ? Icons.volume_off_outlined : Icons.volume_down_rounded,
              ),
            ),
          ),
      ],
    );
  }
}