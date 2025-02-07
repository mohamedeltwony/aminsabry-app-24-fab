import 'package:streamit_flutter/models/movie_episode/common_data_list_model.dart';

class DashboardResponse {
  List<CommonDataListModel>? banner;
  List<Slider>? sliders;
  List<CommonDataListModel>? continueWatch;

  DashboardResponse({
    this.banner,
    this.sliders,
    this.continueWatch,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      banner: json['banner'] != null ? (json['banner'] as List).map((i) => CommonDataListModel.fromJson(i)).toList() : null,
      sliders: json['sliders'] != null ? (json['sliders'] as List).map((i) => Slider.fromJson(i)).toList() : null,
      continueWatch: json['continue_watch'] != null ? (json['continue_watch'] as List).map((i) => CommonDataListModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.continueWatch != null) {
      data['continue_watch'] = this.continueWatch!.map((v) => v.toJson()).toList();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slider {
  List<CommonDataListModel>? data;
  String? title;
  bool? viewAll;
  String? type;

  Slider({this.data, this.title, this.viewAll,this.type});

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      data: json['data'] != null ? (json['data'] as List).map((i) => CommonDataListModel.fromJson(i)).toList() : null,
      title: json['title'],
      viewAll: json['view_all'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['view_all'] = this.viewAll;
    data['type'] = this.type;
    return data;
  }
}
