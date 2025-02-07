import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/screens/playlist/components/create_play_list_widget.dart';
import 'package:streamit_flutter/screens/playlist/components/playlist_item_widget.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  String? playlistType = playlistMovie;
  GlobalKey<PlayListItemWidgetState> movieKey = GlobalKey();
  GlobalKey<PlayListItemWidgetState> episodesKey = GlobalKey();
  GlobalKey<PlayListItemWidgetState> videoKey = GlobalKey();

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 350);
    controller.reverseDuration = const Duration(milliseconds: 350);
    controller.drive(CurveTween(curve: Curves.ease));
  }

  Future<void> createPlayList(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      transitionAnimationController: controller,
      builder: (_) {
        return CreatePlayListWidget(
          onPlaylistCreated: () async {
            await movieKey.currentState?.onCreategrpup(playlistType!);
            if (playlistType == playlistMovie) {
              movieKey.currentState?.refreshPlaylist();
            } else if (playlistType == playlistEpisodes) {
              episodesKey.currentState?.refreshPlaylist();
            } else {
              videoKey.currentState?.refreshPlaylist();
            }
            setState(() {});
          },
          playlistType: playlistType,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(language!.playlist, style: boldTextStyle(size: 22)),
          actions: [
            TextButton(
              onPressed: () {
                createPlayList(context);
              },
              child: Text(language!.createPlaylist, style: primaryTextStyle(size: 14)),
            ).paddingOnly(right: 8),
          ],
          bottom: PreferredSize(
            preferredSize: Size(context.width(), 45),
            child: Align(
              alignment: Alignment.topLeft,
              child: TabBar(
                indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                indicatorWeight: 0.0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: boldTextStyle(size: ts_small.toInt()),
                indicatorColor: colorPrimary,
                indicator: TabIndicator(),
                onTap: (i) {
                  if (i == 0) {
                    playlistType = playlistMovie;
                  } else if (i == 1) {
                    playlistType = playlistEpisodes;
                  } else {
                    playlistType = playlistVideo;
                  }
                },
                unselectedLabelStyle: secondaryTextStyle(size: ts_small.toInt()),
                unselectedLabelColor: Theme.of(context).textTheme.titleLarge!.color,
                labelColor: colorPrimary,
                labelPadding: EdgeInsets.only(left: spacing_large, right: spacing_large),
                tabs: [
                  Tab(child: Text(language!.movies)),
                  Tab(child: Text(language!.episodes)),
                  Tab(child: Text(language!.videos)),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top:16),
          child: TabBarView(
            children: [
              PlayListItemWidget(
                key: movieKey,
                playlistType: playlistMovie,
                onPlaylistDelete: () async {
                  await movieKey.currentState?.onCreategrpup(playlistMovie);
                  if (playlistType == playlistMovie) {
                    movieKey.currentState?.refreshPlaylist();
                  } else if (playlistType == playlistEpisodes) {
                    episodesKey.currentState?.refreshPlaylist();
                  } else {
                    videoKey.currentState?.refreshPlaylist();
                  }
                  setState(() {});
                },
              ),
              PlayListItemWidget(
                key: episodesKey,
                playlistType: playlistEpisodes,
                onPlaylistDelete: () async{
                  await movieKey.currentState?.onCreategrpup(playlistEpisodes);
                  if (playlistType == playlistMovie) {
                    movieKey.currentState?.refreshPlaylist();
                  } else if (playlistType == playlistEpisodes) {
                    episodesKey.currentState?.refreshPlaylist();
                  } else {
                    videoKey.currentState?.refreshPlaylist();
                  }
                  setState(() {});
                },
              ),
              PlayListItemWidget(
                key: videoKey,
                playlistType: playlistVideo,
                onPlaylistDelete: () async{
                  await movieKey.currentState?.onCreategrpup(playlistVideo);
                  if (playlistType == playlistMovie) {
                    movieKey.currentState?.refreshPlaylist();
                  } else if (playlistType == playlistEpisodes) {
                    episodesKey.currentState?.refreshPlaylist();
                  } else {
                    videoKey.currentState?.refreshPlaylist();
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
