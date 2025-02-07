import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/auth/sign_in.dart';
import 'package:streamit_flutter/screens/playlist/components/playlist_list_widget.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';

// ignore: must_be_immutable
class MovieDetailLikeWatchListWidget extends StatefulWidget {
  static String tag = '/LikeWatchlistWidget';

  final VoidCallback? onAction;
  final int postId;
  bool? isInWatchList;
  bool? isLiked;
  int? likes;
  final PostType postType;

  MovieDetailLikeWatchListWidget({
    this.onAction,
    required this.postId,
    this.isInWatchList,
    this.isLiked,
    this.likes,
    required this.postType,
  });

  @override
  MovieDetailLikeWatchListWidgetState createState() => MovieDetailLikeWatchListWidgetState();
}

class MovieDetailLikeWatchListWidgetState extends State<MovieDetailLikeWatchListWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  Future<void> watchlistClick() async {
    if (!mIsLoggedIn) {
      SignInScreen().launch(context);
      return;
    }
    Map req = {
      'post_id': widget.postId.validate(),
      'user_id': getIntAsync(USER_ID),
      'post_type':widget.postType == PostType.MOVIE ? 'movie' : widget.postType == PostType.TV_SHOW ? 'tv_show' : 'video',
      'action': widget.isInWatchList.validate() ? 'remove' : 'add',
    };

    widget.isInWatchList = !widget.isInWatchList.validate();
    setState(() {});

    await watchlistMovie(req).then((res) {
      //
    }).catchError((e) {
      widget.isInWatchList = !widget.isInWatchList.validate();
      toast(e.toString());

      setState(() {});
    });
  }

  Future<void> likeClick() async {
    if (!mIsLoggedIn) {
      SignInScreen().launch(context);
      return;
    }

    Map req = {
      'post_id': widget.postId.validate(),
      'post_type': widget.postType == PostType.MOVIE ? 'movie' : widget.postType == PostType.TV_SHOW ? 'tv_show' : 'video',
    };
    widget.isLiked = !widget.isLiked.validate();

    if (widget.isLiked.validate()) {
      widget.likes = widget.likes.validate() + 1;
    } else {
      widget.likes = widget.likes.validate() - 1;
    }
    setState(() {});

    await likeMovie(req).then((res) {}).catchError((e) {
      widget.isLiked = !widget.isLiked.validate();
      if (widget.isLiked.validate()) {
        widget.likes = widget.likes! + 1;
      } else {
        widget.likes = widget.likes! - 1;
      }
      toast(e.toString());

      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade800),shape: BoxShape.circle),
                child: IconButton(
                  onPressed: likeClick,
                  icon: Icon(widget.isLiked.validate() ? Icons.favorite : Icons.favorite_border, color: textColorSecondary),
                ),
              ),
              8.width,
              DecoratedBox(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade800),shape: BoxShape.circle),
                child: IconButton(
                  onPressed: watchlistClick,
                  icon: Icon(widget.isInWatchList.validate() ? Icons.bookmark : Icons.bookmark_border, color: textColorSecondary),
                ),
              ),
              8.width,
              if (widget.postType != PostType.TV_SHOW)
                DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade800),shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: (){
                      if (appStore.isLogging) {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: radiusCircular(defaultRadius+8),topLeft: radiusCircular(defaultRadius+8))),
                          builder: (dialogContext) {
                            return PlaylistListWidget(
                              playlistType: widget.postType == PostType.MOVIE
                                  ? playlistMovie
                                  : widget.postType == PostType.TV_SHOW
                                  ? playlistTvShows
                                  : playlistVideo,
                              postId: widget.postId.validate(),
                            );
                          },
                        );
                      } else {
                        SignInScreen().launch(context);
                      }
                    },
                    icon: Icon(Icons.library_add_outlined, color: textColorSecondary),
                  ),
                ),
            ],
          ),
        ),
        6.height,
        Text('♡ ${buildLikeCountText(widget.likes.validate())}',style: secondaryTextStyle()).paddingSymmetric(horizontal: 8),
      ],
    );
  }
}
