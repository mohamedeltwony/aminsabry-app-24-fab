import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/common_list_item_component.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/models/live_tv/live_channel_detail_model.dart';
import 'package:streamit_flutter/models/movie_episode/common_data_list_model.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/live_tv/components/live_card.dart';
import 'package:streamit_flutter/screens/live_tv/screens/live_channel_detail_screen.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class ItemHorizontalList extends StatefulWidget {
  List<CommonDataListModel> list = [];
  EdgeInsets? padding;
  bool isContinueWatch;
  bool isLandscape;
  final VoidCallback? onListEmpty;
  final bool isTop10;
  final bool isLiveTv;

  ItemHorizontalList(
    this.list, {
    this.isContinueWatch = false,
    this.onListEmpty,
    this.padding,
    this.isTop10 = false,
    this.isLandscape = false,
    this.isLiveTv = false,
  });

  @override
  _ItemHorizontalListState createState() => _ItemHorizontalListState();
}

class _ItemHorizontalListState extends State<ItemHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      itemCount: widget.list.length,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        CommonDataListModel data = widget.list[index];
        ChannelData channelDetailModel = ChannelData(
          details: Details(
            id: data.id.validate(),
            postType: PostType.LIVE_TV,
            description: data.description.validate(),
            url: data.trailerLink.validate(),
            streamType: data.channelStreamType.validate(),
            title: data.title.validate(),
            image: data.image.validate(),
            shareUrl: data.shareUrl.validate(),
            genre: [data.category.validate()],
          ),
          recommendedChannels: [],
        );
        return Stack(
          children: [
            CommonListItemComponent(
              data: data,
              isLandscape: widget.isLandscape,
              isContinueWatch: widget.isContinueWatch,
              onTap: widget.isLiveTv
                  ? () {
                      LiveChannelDetailScreen(
                        channelData: channelDetailModel,
                        key: ValueKey(index),
                      ).launch(context);
                    }
                  : null,
              callback: () {
                deleteVideoContinueWatch(postId: data.id.validate()).then((value) {
                  appStore.removeFromWatchContinue(appStore.continueWatchList.firstWhere((element) => element.postId.toInt() == data.id.validate()));
                }).catchError(onError);
                widget.list.removeAt(index);
                if (widget.list.isEmpty) widget.onListEmpty?.call();
                setState(() {});
              },
            ),
            if (widget.isTop10.validate())
              Positioned(
                top: -5,
                right: 4,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            if (widget.isLiveTv)
              Positioned(
                top: 10,
                left: 10,
                child: LiveTagComponent(),
              )
          ],
        );
      },
    );
  }
}
