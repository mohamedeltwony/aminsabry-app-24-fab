import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CachedImageWidget extends StatelessWidget {
  final String url;
  final double height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final String? placeHolderImage;
  final AlignmentGeometry? alignment;
  final bool usePlaceholderIfUrlEmpty;
  final bool circle;
  final double? radius;

  CachedImageWidget({
    required this.url,
    this.height = 0.0,
    this.width,
    this.fit,
    this.color,
    this.placeHolderImage,
    this.alignment,
    this.radius,
    this.usePlaceholderIfUrlEmpty = true,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {


    if (url.validate().isEmpty) {
      return Container(
        height: height,
        width: width ?? height,
        color: color ?? grey.withValues(alpha:0.1),
        alignment: alignment,
        child: PlaceHolderWidget(
          height: height,
          width: width,
          alignment: alignment ?? Alignment.center,
        ).cornerRadiusWithClipRRect(radius ?? (circle ? (height / 2) : 0)),
      ).cornerRadiusWithClipRRect(radius ?? (radius ?? (circle ? (height / 2) : 0)));
    } else if (url.validate().startsWith('http')) {
      return CachedNetworkImage(
        placeholder: (_, __) {
          return placeHolderWidget(
            placeHolderImage: placeHolderImage,
            height: height,
            width: width ?? height,
            fit: fit,
            alignment: alignment,
          ).cornerRadiusWithClipRRect(radius ?? (circle ? (height / 2) : 0));
        },
        imageUrl: url,
        height: height,
        width: width ?? height,
        fit: fit,
        color: color,
        alignment: alignment as Alignment? ?? Alignment.center,
        errorWidget: (_, s, d) {
          return placeHolderWidget(
            placeHolderImage: placeHolderImage,
            height: height,
            width: width ?? height,
            fit: fit,
            alignment: alignment,
          ).cornerRadiusWithClipRRect(radius ?? (circle ? (height / 2) : 0));
        },
      ).cornerRadiusWithClipRRect(radius ?? (circle ? (height / 2) : 0));
    } else {
      return Image.asset(
        url,
        height: height,
        width: width ?? height,
        fit: fit,
        color: color,
        alignment: alignment ?? Alignment.center,
        errorBuilder: (_, s, d) {
          return placeHolderWidget(
            height: height,
            width: width ?? height,
            fit: fit,
            alignment: alignment,
          ).cornerRadiusWithClipRRect(radius ?? (circle ? (height / 2) : 0));
        },
      ).cornerRadiusWithClipRRect(radius ?? (circle ? (height / 2) : 0));
    }
  }
}

Widget placeHolderWidget({String? placeHolderImage, double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment}) {
  return PlaceHolderWidget(
    height: height,
    width: width,
    alignment: alignment ?? Alignment.center,
  );
}
