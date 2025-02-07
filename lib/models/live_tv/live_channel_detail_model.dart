import 'package:streamit_flutter/models/movie_episode/common_data_list_model.dart';

import '../../utils/constants.dart';


class ChannelData {
  Details details;
  List<CommonDataListModel> recommendedChannels;

  ChannelData({
    required this.details,
    this.recommendedChannels = const <CommonDataListModel>[],
  });

  factory ChannelData.fromJson(Map<String, dynamic> json) {
    return ChannelData(
      details: json['details'] is Map ? Details.fromJson(json['details']) : Details(),
      recommendedChannels: json['recommended_channels'] is List ? List<CommonDataListModel>.from(json['recommended_channels'].map((x) => CommonDataListModel.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'details': details.toJson(),
      'recommended_channels': recommendedChannels.map((e) => e.toJson()).toList(),
    };
  }
}

class Details {
  int id;
  String title;
  String image;
  PostType postType;
  String streamType;
  String url;
  String description;
  String excerpt;
  String shareUrl;
  bool isCommentOpen;
  int noOfComments;
  int likes;
  String isLiked;
  bool isWatchlist;
  List<String> genre;
  int views;
  String publishDate;
  String publishDateGmt;
  List<dynamic> comments;
  bool isPasswordProtected;
  bool userHasAccess;
  List<dynamic> subscriptionLevels;

  Details({
    this.id = -1,
    this.title = "",
    this.image = "",
    this.postType = PostType.LIVE_TV,
    this.streamType = "",
    this.url = "",
    this.description = "",
    this.excerpt = "",
    this.shareUrl = "",
    this.isCommentOpen = false,
    this.noOfComments = -1,
    this.likes = -1,
    this.isLiked = "",
    this.isWatchlist = false,
    this.genre = const <String>[],
    this.views = -1,
    this.publishDate = "",
    this.publishDateGmt = "",
    this.comments = const [],
    this.isPasswordProtected = false,
    this.userHasAccess = false,
    this.subscriptionLevels = const [],
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'] is int ? json['id'] : -1,
      title: json['title'] is String ? json['title'] : "",
      image: json['image'] is String ? json['image'] : "",
      postType: PostType.LIVE_TV,
      streamType: json['stream_type'] is String ? json['stream_type'] : "",
      url: json['url'] is String ? json['url'] : "",
      description: json['description'] is String ? json['description'] : "",
      excerpt: json['excerpt'] is String ? json['excerpt'] : "",
      shareUrl: json['share_url'] is String ? json['share_url'] : "",
      isCommentOpen: json['is_comment_open'] is bool ? json['is_comment_open'] : false,
      noOfComments: json['no_of_comments'] is int ? json['no_of_comments'] : -1,
      likes: json['likes'] is int ? json['likes'] : -1,
      isLiked: json['is_liked'] is String ? json['is_liked'] : "",
      isWatchlist: json['is_watchlist'] is bool ? json['is_watchlist'] : false,
      genre: json['genre'] is List ? List<String>.from(json['genre'].map((x) => x)) : [],
      views: json['views'] is int ? json['views'] : -1,
      publishDate: json['publish_date'] is String ? json['publish_date'] : "",
      publishDateGmt: json['publish_date_gmt'] is String ? json['publish_date_gmt'] : "",
      comments: json['comments'] is List ? json['comments'] : [],
      isPasswordProtected: json['is_password_protected'] is bool ? json['is_password_protected'] : false,
      userHasAccess: json['user_has_access'] is bool ? json['user_has_access'] : false,
      subscriptionLevels: json['subscription_levels'] is List ? json['subscription_levels'] : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'post_type': postType,
      'stream_type': streamType,
      'url': url,
      'description': description,
      'excerpt': excerpt,
      'share_url': shareUrl,
      'is_comment_open': isCommentOpen,
      'no_of_comments': noOfComments,
      'likes': likes,
      'is_liked': isLiked,
      'is_watchlist': isWatchlist,
      'genre': genre.map((e) => e).toList(),
      'views': views,
      'publish_date': publishDate,
      'publish_date_gmt': publishDateGmt,
      'comments': [],
      'is_password_protected': isPasswordProtected,
      'user_has_access': userHasAccess,
      'subscription_levels': [],
    };
  }
}
