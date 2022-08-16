import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CacheImage extends StatelessWidget{
  const CacheImage({Key? key,required this.imageUrl,this.width,this.height,this.fit = BoxFit.cover}) : super(key: key);
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        placeholder: (_, __) => LoadingIcon(),
        fit: fit,
      );
    }catch(e){
      return Container();
    }
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[200],
      child: Center(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.color),
          child: loadLocalImage(
            "logo",
            width: Adapt.px(36),
          ),
        ),
      ),
    );
  }
}
