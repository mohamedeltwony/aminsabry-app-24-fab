import 'package:streamit_flutter/models/resume_video_model.dart';
import 'package:streamit_flutter/utils/constants.dart';

class CommonDataListModel {
  int? id;
  String? title;
  String? image;
  PostType postType;
  String? characterName;
  String? releaseYear;
  String? shareUrl;
  String? runTime;
  ContinueWatchModel? watchedDuration;
  String? trailerLink;
  String? attachment;
  String? releaseDate;
  String? category;
  String? description;
  String? trailerLinkType;
  String? channelStreamType;

  CommonDataListModel({
    this.id,
    this.title,
    this.image,
    required this.postType,
    this.characterName,
    this.releaseYear,
    this.shareUrl,
    this.runTime,
    this.watchedDuration,
    this.trailerLink,
    this.attachment,
    this.releaseDate,
    this.category,
    this.description,
    this.trailerLinkType,
    this.channelStreamType,
  });

  factory CommonDataListModel.fromJson(Map<String, dynamic> json) {
    return CommonDataListModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      postType: (json['post_type'] != null)
          ? {
        'movie': PostType.MOVIE,
        'episode': PostType.EPISODE,
        'tv_show': PostType.TV_SHOW,
        'video': PostType.VIDEO,
        'live_tv': PostType.LIVE_TV,
      }[json['post_type']] ??
          PostType.NONE
          : PostType.NONE,
      characterName: json['character_name'],
      releaseYear: json['release_year'],
      shareUrl: json['share_url'],
      runTime: json['run_time'],
      watchedDuration: json['watched_duration'] != null ? ContinueWatchModel.fromJson(json['watched_duration']) : null,
      trailerLink: json['trailer_link'],
      attachment: json['attachment'],
      releaseDate: json['release_date'],
      trailerLinkType: json["trailer_link_type"],
      channelStreamType: json['stream_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['postType'] = this.postType.toString();
    data['character_name'] = this.characterName;
    data['release_year'] = this.releaseYear;
    data['share_url'] = this.shareUrl;
    data['run_time'] = this.runTime;
    if (this.watchedDuration != null) {
      data['watched_duration'] = this.watchedDuration!.toJson();
    }
    data['trailer_link'] = this.trailerLink;
    data["trailer_link_type"] = this.trailerLinkType;
    data['attachment'] = this.attachment;
    data['release_date'] = this.releaseDate;
    data['stream_type'] = this.channelStreamType;
    return data;
  }
}
