import 'package:flutter/material.dart';
import '../model/index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class HomeTopFocusView extends StatefulWidget {
  HomeTopFocusView({Key? key, this.infos}) : super(key: key);
  List<Infos>? infos;

  _HomeTopFocusViewState createState() => _HomeTopFocusViewState();
}

class _HomeTopFocusViewState extends State<HomeTopFocusView> {
  _buildPlugin() {
    return SwiperPagination();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext content, int index) {
          return CacheImage(
            imageUrl: widget.infos![index].imgUrl!,
            width: double.infinity,
            height: double.infinity,
          );
        },
        itemCount: widget.infos!.length,
        autoplay: true,
        autoplayDelay: 3000,
        // pagination: _buildPlugin(),
        onTap: (index) {
          print(" 点击 " + index.toString());
        },
        viewportFraction: 1,
        autoplayDisableOnInteraction: true,
        loop: true,
        scale: 1,
      ),
    );
  }
}
