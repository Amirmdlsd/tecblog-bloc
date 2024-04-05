import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CachedImage extends StatelessWidget {
  CachedImage(
      {super.key,
      required this.imageUrl,
      this.widget = const SpinKitWave(
        size: 22,
        color: Colors.purple,
      ),
      this.errorWidget = const Icon(Icons.image_not_supported, size: 30)});
  String imageUrl;
  Widget widget;
  Widget errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => widget,
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitWave(
      size: 22,
      color: Colors.purple,
    );
  }
}
