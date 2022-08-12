import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/modules/home/model/home_ad.dart';

class MineADView extends StatefulWidget {
  MineADView({Key? key, this.advertData}) : super(key: key);
  AdvertListData? advertData;

  _MineADViewState createState() => _MineADViewState();
}

class _MineADViewState extends State<MineADView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.advertData != null) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: Adapt.px(90),
        child: CacheImage(
          imageUrl: widget.advertData!.imgUrl!,
          width: Adapt.px(double.infinity),
          height: Adapt.px(90),
        ),
      );
    }
    return Container();
  }
}
