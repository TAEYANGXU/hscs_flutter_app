import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';

class VipSectionView extends StatelessWidget {
  VipSectionView({Key? key, this.title = "", this.icon = "",this.router = ""})
      : super(key: key);

  String icon;
  String title;
  String router;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            //
            child: Container(
              padding: EdgeInsets.only(left: Adapt.px(15)),
              child: Row(
                children: [
                  loadLocalImage(icon,width: Adapt.px(15),height: Adapt.px(16)),
                  SizedBox(width: Adapt.px(3),),
                  Text(title,style: TextStyle(fontSize: TextSize.larger,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            // padding: EdgeInsets.only(right: 0),
            child: GestureDetector(
              onTap: () {
                print("更多");
              },
              child: Row(
                children: [
                  Text(
                    '更多',
                    style: TextStyle(color: AppColors.orangeText),
                  ),
                  loadLocalImage("home_more_arrow",
                      width: Adapt.px(9), height: Adapt.px(14)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
