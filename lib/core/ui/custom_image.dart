import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../helpers/app_colors.dart';

class CustomImageNetwork extends StatelessWidget {
  final String? imageURL;
  final String? placeHolderImageURL;
  final String? assetImageOnError;

  const CustomImageNetwork(
      {Key? key,
      required this.imageURL,
      this.placeHolderImageURL,
      this.assetImageOnError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: imageURL ??
          placeHolderImageURL ??
          'https://seatgeek.com/images/performers-landscape/rolling-loud-festival-592d10/302050/huge.jpg',
      placeholder: (context, url) => const Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(
        assetImageOnError ?? 'assets/images/seat-geek.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
