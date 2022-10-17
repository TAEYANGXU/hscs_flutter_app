import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../model/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:hscs_flutter_app/routers.dart';
import '../router.dart';

class HomeSudokuView extends StatefulWidget {
  HomeSudokuView({Key? key, this.iconList}) : super(key: key);
  List<IconList>? iconList;

  _HomeSudokuViewState createState() => _HomeSudokuViewState();
}

class _HomeSudokuViewState extends State<HomeSudokuView> {
  List<Widget> getItems() {
    List<Widget> list = [];
    for (var i = 0; i < widget.iconList!.length; i++) {
      var icon = widget.iconList![i];
      list.add(buildItem(context, i));
    }
    return list;
  }

  Widget buildItem(BuildContext context, int index) {
    var icon = widget.iconList![index];
    return GestureDetector(
        onTap: () async {
          debugPrint("index = $index");
          debugPrint("deepLink = ${icon.deepLink}");
          if(icon.deepLink!.contains('http')){
            await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":icon.deepLink!});
          }else if(icon.deepLink!.contains('free_video')){
            Routers.push(context, HomeRouter.videoList,params: {"type":"2"});
          }
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              CacheImage(
                imageUrl: icon.iconurl!,
                width: Adapt.px(30),
                height: Adapt.px(30),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                icon.name!,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: AppColors.text, fontSize: TextSize.main),
              ),
            ],
          ),
        ));
  }

  double getHeight() {
    var size = widget.iconList!.length;
    var col = widget.iconList!.length / 4;
    if (widget.iconList!.length % 4 > 0) {
      col += 1;
    }
    print("col = $col");
    print("size = $size");
    return col * (col == 2 ? Adapt.px(90) : Adapt.px(72));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      height: getHeight(),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        // scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 15),
        physics: const NeverScrollableScrollPhysics(),
        children: getItems(),
      ),
    );
  }
}
