import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/routers.dart';

class VipSectionView extends StatelessWidget {
  VipSectionView({Key? key, this.title = "", this.icon = "",this.router = "",this.params})
      : super(key: key);

  String icon;
  String title;
  String router;
  Map<String,dynamic>? params;

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
                  SizedBox(width: Adapt.px(5),),
                  Text(title,style: const TextStyle(fontSize: TextSize.larger,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            // padding: EdgeInsets.only(right: 0),
            child: GestureDetector(
              onTap: () {
                print("更多1");
                Routers.push(context, router,params: params);
              },
              child: Row(
                children: [
                  const Text(
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
