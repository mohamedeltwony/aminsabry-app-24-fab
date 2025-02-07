import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/movie_episode/movie_detail_common_models.dart';
import 'package:streamit_flutter/models/movie_episode/sources.dart';
import 'package:streamit_flutter/utils/constants.dart';

class MovieData {
  String? description;
  String? excerpt;
  List<String>? genre;
  int? id;
  String? image;
  List<String>? tag;
  String? title;
  String? logo;
  String? avgRating;
  String? censorRating;
  String? embedContent;
  String? choice;
  String? publishDate;
  String? publishDateGmt;
  String? releaseDate;
  String? runTime;
  String? trailerLink;
  String? urlLink;
  String? file;
  bool? isInWatchList;
  bool? isLiked;
  int? likes;
  String? attachment;
  List<RestrictSubscriptionPlan>? subscriptionLevels;
  String? noOfComments;
  dynamic imdbRating;
  MovieSeason? seasons;
  int? views;
  PostType? postType;
  List<CommonModelMovieDetail>? castsList;
  List<CommonModelMovieDetail>? crews;
  String? shareUrl;
  bool? userHasAccess;
  List<Sources>? sourcesList;
  bool? isCommentOpen;
  List<MovieComment>? comments;
  String? episodeFile;
  bool? isPasswordProtected;

  String trailerLinkType;

  MovieData(
      {this.avgRating,
      this.censorRating,
      this.description,
      this.embedContent,
      this.excerpt,
      this.genre,
      this.id,
      this.image,
      this.logo,
      this.tag,
      this.title,
      this.choice,
      this.publishDate,
      this.publishDateGmt,
      this.releaseDate,
      this.runTime,
      this.trailerLink,
      this.urlLink,
      this.isInWatchList,
      this.isLiked,
      this.likes,
      this.postType,
      this.file,
      this.attachment,
      this.subscriptionLevels,
      this.views,
      this.imdbRating,
      this.noOfComments,
      this.castsList,
      this.shareUrl,
      this.sourcesList,
      this.isCommentOpen,
      this.crews,
      this.userHasAccess,
      this.seasons,
      this.comments,
      this.episodeFile,
      this.isPasswordProtected,
      this.trailerLinkType = ''});

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      avgRating: json['avg_rating'],
      censorRating: json['censor_rating'],
      description: json['description'],
      excerpt: json['excerpt'],
      embedContent: json['embed_content'],
      genre: json['genre'] != null ? new List<String>.from(json['genre']) : null,
      id: json['id'].toString().toInt(),
      image: json['image'],
      tag: json['tag'] != null ? new List<String>.from(json['tag']) : null,
      title: json['title'],
      logo: json['logo'],
      likes: json['likes'],
      choice: json['post_type'] != null
          ? json['post_type'] == 'movie'
              ? json['movie_choice']
              : json['post_type'] == 'episode'
                  ? json['episode_choice']
                  : json['video_choice']
          : null,
      publishDate: json['publish_date'],
      publishDateGmt: json['publish_date_gmt'],
      releaseDate: json['release_date'],
      runTime: json['run_time'],
      trailerLink: json['trailer_link'],
      urlLink: json['url_link'],
      isInWatchList: json['is_watchlist'],
      file: json['post_type'] != null
          ? json['post_type'] == 'movie'
              ? json['movie_file']
              : json['video_file']
          : null,
      isLiked: json['is_liked'] != null
          ? json['is_liked'] == postLike
              ? true
              : false
          : false,
      postType: json['post_type'] != null
          ? json['post_type'] == 'movie'
              ? PostType.MOVIE
              : json['post_type'] == 'episode'
                  ? PostType.EPISODE
                  : json['post_type'] == 'tv_show'
                      ? PostType.TV_SHOW
                      : json['post_type'] == 'video'
                          ? PostType.VIDEO
                          : PostType.NONE
          : PostType.NONE,
      attachment: json['attachment'],
      subscriptionLevels: json['subscription_levels'] != null ? (json['subscription_levels'] as List).map((e) => RestrictSubscriptionPlan.fromJson(e)).toList() : null,
      views: json['views'],
      imdbRating: json['imdb_rating'] != null ? json['imdb_rating'] : null,
      noOfComments: json['no_of_comments'],
      castsList: json['casts'] != null ? (json['casts'] as List).map((e) => CommonModelMovieDetail.fromJson(e)).toList() : null,
      crews: json['crews'] != null ? (json['crews'] as List).map((e) => CommonModelMovieDetail.fromJson(e)).toList() : null,
      shareUrl: json['share_url'],
      sourcesList: json['sources'] == null ? [] : (json['sources'] as List).map((e) => Sources.fromJson(e)).toList(),
      isCommentOpen: json['is_comment_open'],
      userHasAccess: json['user_has_access'],
      seasons: json['seasons'] != null ? MovieSeason.fromJson(json['seasons']) : null,
      episodeFile: json['episode_file'],
      isPasswordProtected: json['is_password_protected'] is bool ?json['is_password_protected'] :false,
      trailerLinkType: json['trailer_link_type'] is String ? json['trailer_link_type'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_file'] = this.file;
    data['description'] = this.description;
    data['excerpt'] = this.excerpt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['avg_rating'] = this.avgRating;
    data['censor_rating'] = this.censorRating;
    data['embed_content'] = this.embedContent;
    data['movie_choice'] = this.choice;
    data['publish_date'] = this.publishDate;
    data['publish_date_gmt'] = this.publishDateGmt;
    data['release_date'] = this.releaseDate;
    data['run_time'] = this.runTime;
    data['trailer_link'] = this.trailerLink;
    data['url_link'] = this.urlLink;
    data['logo'] = this.logo;
    data['is_watchlist'] = this.isInWatchList;
    data['is_liked'] = this.isLiked;
    data['likes'] = this.likes;
    data['episode_file'] = this.episodeFile;
    data['postType'] = this.postType.toString();
    if (this.genre != null) {
      data['genre'] = this.genre;
    }
    if (this.tag != null) {
      data['tag'] = this.tag;
    }

    data['attachment'] = this.attachment;
    if (this.subscriptionLevels != null) {
      data['subscription_levels'] = this.subscriptionLevels!.map((e) => e.toJson()).toList();
    }
    data['views'] = this.views;
    data['imdb_rating'] = this.imdbRating;
    data['no_of_comments'] = this.noOfComments;
    if (data['casts'] != null) {
      data['casts'] = this.castsList;
    }
    if (data['crews'] != null) {
      data['crews'] = this.crews;
    }
    data['share_url'] = this.shareUrl;
    if (data['sources'] != null) {
      data['sources'] = this.sourcesList!.map((e) => e.toJson()).toList();
    }
    data['is_comment_open'] = this.isCommentOpen;

    data['user_has_access'] = this.userHasAccess;
    if (this.seasons != null) {
      data['seasons'] = this.seasons!.toJson();
    }
    if (data['comments'] != null) {
      data['comments'] = this.comments!.map((e) => e.toJson()).toList();
    }

    data['is_password_protected'] = this.isPasswordProtected;
    data['trailer_link_type'] = this.trailerLinkType;
    return data;
  }
}

class MovieComment {
  MovieComment({
    this.commentID,
    this.commentPostID,
    this.commentAuthor,
    this.commentAuthorEmail,
    this.commentAuthorUrl,
    this.commentAuthorIP,
    this.commentDate,
    this.commentDateGmt,
    this.commentContent,
    this.commentKarma,
    this.commentApproved,
    this.commentAgent,
    this.commentType,
    this.commentParent,
    this.userId,
    this.rating,
  });

  MovieComment.fromJson(dynamic json) {
    commentID = json['comment_ID'];
    commentPostID = json['comment_post_ID'];
    commentAuthor = json['comment_author'];
    commentAuthorEmail = json['comment_author_email'];
    commentAuthorUrl = json['comment_author_url'];
    commentAuthorIP = json['comment_author_IP'];
    commentDate = json['comment_date'];
    commentDateGmt = json['comment_date_gmt'];
    commentContent = json['comment_content'];
    commentKarma = json['comment_karma'];
    commentApproved = json['comment_approved'];
    commentAgent = json['comment_agent'];
    commentType = json['comment_type'];
    commentParent = json['comment_parent'];
    userId = json['user_id'];
    rating = json['rating'];
  }

  String? commentID;
  String? commentPostID;
  String? commentAuthor;
  String? commentAuthorEmail;
  String? commentAuthorUrl;
  String? commentAuthorIP;
  String? commentDate;
  String? commentDateGmt;
  String? commentContent;
  String? commentKarma;
  String? commentApproved;
  String? commentAgent;
  String? commentType;
  String? commentParent;
  String? userId;
  int? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment_ID'] = commentID;
    map['comment_post_ID'] = commentPostID;
    map['comment_author'] = commentAuthor;
    map['comment_author_email'] = commentAuthorEmail;
    map['comment_author_url'] = commentAuthorUrl;
    map['comment_author_IP'] = commentAuthorIP;
    map['comment_date'] = commentDate;
    map['comment_date_gmt'] = commentDateGmt;
    map['comment_content'] = commentContent;
    map['comment_karma'] = commentKarma;
    map['comment_approved'] = commentApproved;
    map['comment_agent'] = commentAgent;
    map['comment_type'] = commentType;
    map['comment_parent'] = commentParent;
    map['user_id'] = userId;
    map['rating'] = rating;
    return map;
  }
}
