import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../model/home_model.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';

class HomeSudokuView extends StatefulWidget {
  HomeSudokuView({Key? key, this.iconList}) : super(key: key);
  List<IconlistData>? iconList;

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
        onTap: () {
          debugPrint("index = $index");
        },
        child: Container(
          child: Column(
            children: [
              CacheImage(
                imageUrl: icon.iconurl!,
                width: Adapt.px(25),
                height: Adapt.px(29),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                icon.name!,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: AppColors.text, fontSize: TextSize.main),
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
    return col * Adapt.px(100);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: getHeight(),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        children: getItems(),
        // scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 30),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
