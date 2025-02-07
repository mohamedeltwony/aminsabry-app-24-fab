import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/loading_dot_widget.dart';
import 'package:streamit_flutter/screens/genre/genre_grid_list_widget.dart';
import 'package:streamit_flutter/components/loader_widget.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/models/genre_data.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/utils/cached_data.dart';
import 'package:streamit_flutter/utils/common.dart';

class GenreListScreen extends StatefulWidget {
  static String tag = '/GenreListScreen';
  final String? type;

  GenreListScreen({this.type});

  @override
  GenreListScreenState createState() => GenreListScreenState();
}

class GenreListScreenState extends State<GenreListScreen> {
  Future<List<GenreData>>? future;
  ScrollController scrollController = ScrollController();
  List<GenreData> genreList = [];

  bool isLastPage = false;

  int page = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init({bool showLoader = false}) async {
    if (showLoader) {
      appStore.setLoading(true);
    }
    future = await getGenreList(
      type: widget.type,
      page: page,
      genreDataList: genreList,
      lastPageCallback: (b) => isLastPage = b,
    ).then((value) {
      if (page == 1) {
        GenreCachedData.storeData(genreTypeKey: widget.type.validate(), data: value.map((e) => e.toJson()).toList());
      }
      setState(() {});
      appStore.setLoading(false);
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
      toast(error.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        child: Stack(
          children: [
            SnapHelperWidget(
              future: future,
              key: UniqueKey(),
              initialData: GenreCachedData.getData(dashboardTypeKey: widget.type.validate()),
              loadingWidget: LoaderWidget(),
              errorBuilder: (p0) {
                return NoDataWidget(
                  imageWidget: noDataImage(),
                  title: p0.toString(),
                  retryText: language?.refresh,
                  onRetry: () {
                    init(showLoader: true);
                  },
                );
              },
              onSuccess: (list) {
                return AnimatedScrollView(
                  listAnimationType: ListAnimationType.None,
                  padding: EdgeInsets.only(bottom: isLastPage ? 80 : 0),
                  onNextPage: () {
                    if (!isLastPage) page++;
                    init(showLoader: true);
                    setState(() {});
                  },
                  onSwipeRefresh: () async {
                    init(showLoader: true);
                    return await 2.seconds.delay;
                  },
                  children: [GenreGridListWidget(list, widget.type.validate())],
                );
              },
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 8,
              child: LoadingDotsWidget(),
            ).visible(appStore.isLoading)
          ],
        ),
      ),
    );
  }
}
