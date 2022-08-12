import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import '../model/home_ad.dart';

class HomeBottomView extends StatefulWidget {
  HomeBottomView({Key? key, this.advertData}) : super(key: key);
  AdvertListData? advertData;

  _HomeBottomViewState createState() => _HomeBottomViewState();
}

class _HomeBottomViewState extends State<HomeBottomView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: Adapt.px(220),
      child: CacheImage(
        imageUrl: widget.advertData!.imgUrl!,
        width: Adapt.px(double.infinity),
        height: Adapt.px(220),
      ),
    );
  }
}
