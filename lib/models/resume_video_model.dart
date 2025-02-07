class ContinueWatchModel {
  String? postId;
  String? watchedTime;
  String? watchedTotalTime;
  String? watchedTimePercentage;

  ContinueWatchModel({this.postId, this.watchedTime, this.watchedTimePercentage, this.watchedTotalTime});

  factory ContinueWatchModel.fromJson(Map<String, dynamic> json) {
    return ContinueWatchModel(
      postId: json['post_id'],
      watchedTime: json['watchedTime'].toString(),
      watchedTimePercentage: json['watchedTimePercentage'].toString(),
      watchedTotalTime: json['watchedTotalTime'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': this.postId,
      'watchedTime': this.watchedTime,
      'watchedTimePercentage': this.watchedTimePercentage,
      'watchedTotalTime': this.watchedTotalTime,
    };
  }
}
