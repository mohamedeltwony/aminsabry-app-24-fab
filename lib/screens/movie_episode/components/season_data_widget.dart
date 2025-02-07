import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/episode_item_component.dart';
import 'package:streamit_flutter/components/loading_dot_widget.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/models/movie_episode/movie_data.dart';
import 'package:streamit_flutter/models/movie_episode/movie_detail_common_models.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/movie_episode/screens/episode_detail_screen.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/constants.dart';

import '../../../utils/resources/colors.dart';

class SeasonDataWidget extends StatefulWidget {
  final MovieSeason? movieSeason;
  final int postId;
  final ScrollController scrollController;
  CommonModelMovieDetail dropdownValue;

  SeasonDataWidget({this.movieSeason, required this.postId, required this.scrollController, required this.dropdownValue});

  @override
  SeasonDataWidgetState createState() => SeasonDataWidgetState();
}

class SeasonDataWidgetState extends State<SeasonDataWidget> {
  int mPage = 1;
  bool mIsLastPage = false;
  bool isLoading = false;
  bool isError = false;

  List<MovieData> episodes = [];

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent) {
        if (!mIsLastPage) {
          mPage++;
          getSeasonDetails();
        }
      }
    });

    init();
  }

  init() async {
    getSeasonDetails();
  }

  Future<void> getSeasonDetails() async {
    isError = false;
    isLoading = true;
    setState(() {});
    await tvShowSeasonDetail(showId: widget.postId.validate(), seasonId: widget.dropdownValue.id.validate().toInt(), page: mPage).then((value) {
      mIsLastPage = value.episodes.validate().length != postPerPage;

      episodes.addAll(value.episodes.validate());
      isLoading = false;

      setState(() {});
    }).catchError((e) {
      log(e.toString());
      isError = true;
      isLoading = false;
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
        DropdownButtonHideUnderline(
          child: DropdownButton<CommonModelMovieDetail>(
            padding: EdgeInsets.zero,
            dropdownColor: search_edittext_color,
            value: widget.dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            borderRadius: BorderRadius.circular(defaultRadius),
            elevation: 0,
            style: primaryTextStyle(),
            onChanged: (CommonModelMovieDetail? newValue) {
              if (newValue != null && widget.dropdownValue != newValue) {
                mPage = 1;
                episodes.clear();
                widget.dropdownValue = newValue;
                getSeasonDetails();

                setState(() {});
              }
            },
            items: widget.movieSeason!.data.validate().map<DropdownMenuItem<CommonModelMovieDetail>>(
              (season) {
                return DropdownMenuItem(
                  value: season,
                  child: Text(season.name.validate(), style: primaryTextStyle()),
                );
              },
            ).toList(),
          ).paddingOnly(left: 16),
        ),
        16.height,
        if (!isError && episodes.validate().isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: episodes.validate().length,
            itemBuilder: (_, index) {
              MovieData episode = episodes.validate()[index];
              return EpisodeItemComponent(
                episode: episode,
                callback: () {
                  LiveStream().emit(PauseVideo);
                  EpisodeDetailScreen(
                    title: episode.title.validate(),
                    episode: episode,
                    episodes: episodes,
                    index: index,
                    lastIndex: episodes.validate().length,
                  ).launch(context);
                },
              );
            },
          )
          else if(episodes.validate().isEmpty)
           NoDataWidget(
            imageWidget: noDataImage(),
            title: language!.notFound,
          )
        else
          NoDataWidget(
            imageWidget: noDataImage(),
            title: language!.somethingWentWrong,
          ),
        LoadingDotsWidget().visible(isLoading),
      ],
    );
  }
}
