import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/screens/auth/sign_in.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';

class AddRatingComponent extends StatefulWidget {
  final int postId;
  final bool showComments;
  final Function()? callForRefresh;

  AddRatingComponent({required this.postId, this.callForRefresh, this.showComments = false});

  @override
  _AddRatingComponentState createState() => _AddRatingComponentState();
}

class _AddRatingComponentState extends State<AddRatingComponent> {
  double selectedRating = 0;

  TextEditingController mainCommentCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> postComment() async {
    appStore.setLoading(true);

    await buildComment(content: mainCommentCont.text.trim(), rating: selectedRating, postId: widget.postId).then((value) {
      appStore.setLoading(false);
      selectedRating = 0;
      setState(() {});
      mainCommentCont.clear();
      widget.callForRefresh?.call();
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      color: search_edittext_color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          16.height,
          if (!widget.showComments)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(language!.lblPleaseRateUs, style: secondaryTextStyle()),
                8.height,
                RatingBarWidget(
                  onRatingChanged: (rating) {
                    selectedRating = rating;
                    setState(() {});
                  },
                  activeColor: selectedRating.toInt().getRatingBarColor(),
                  inActiveColor: ratingBarColor,
                  rating: selectedRating,
                  size: 18,
                ),
                18.height,
              ],
            ).paddingSymmetric(horizontal: 16),
          AppTextField(
            controller: mainCommentCont,
            textFieldType: TextFieldType.MULTILINE,
            maxLines: 5,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            textStyle: primaryTextStyle(color: textColorPrimary),
            errorThisFieldRequired: errorThisFieldRequired,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16),
              hintText: widget.showComments ? language!.addAComment : language!.lblAddYourReview,
              hintStyle: secondaryTextStyle(),
              suffixIcon: IconButton(
                icon: Icon(Icons.send, color: colorPrimary),
                color: colorPrimary,
                onPressed: () {
                  hideKeyboard(context);

                  if (appStore.isLogging)
                    postComment();
                  else
                    SignInScreen(
                      redirectTo: () {
                        setState(() {});
                      },
                    ).launch(context);
                },
              ).paddingOnly(right: 8),
              border: UnderlineInputBorder(borderSide: BorderSide(color: colorPrimary)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorPrimary)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}
