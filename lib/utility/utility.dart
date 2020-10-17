import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'appAssets.dart';
import 'appColors.dart';

class Utility {
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Widget progress(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.appColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
          ),
        ),
      ),
    );
  }

  static Widget imageLoader(String url, String placeholder,
      {BoxFit fit = BoxFit.cover}) {
    return (url == "null" || url == null || url.trim() == "")
        ? Image.asset(placeholder)
        : CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            placeholder: (context, url) => progress(context),
            errorWidget: (context, url, error) =>
                Image.asset(AppAssets.imageNotFound),
          );
  }
}
