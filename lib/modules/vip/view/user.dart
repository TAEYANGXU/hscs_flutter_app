import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:provider/provider.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';

class VipUserView extends StatefulWidget {

  VipUserView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipUserViewState();
  }
}

class _VipUserViewState extends State<VipUserView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: Adapt.px(50),
      width: double.infinity,
      child: Consumer<UserInfo>(builder: (context,user,child){
          return Row(
            children: [
              Container(
                width: Adapt.px(45),
                height: Adapt.px(45),
                margin: EdgeInsets.only(left: Adapt.px(10)),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Adapt.px(30))
                ),
                child: user.info == null ? loadLocalImage("mine/mine_default_avtar",
                    width: Adapt.px(45),height: Adapt.px(45)) :
                CacheImage(
                  imageUrl: user.info!.avatar ?? "",
                  width: Adapt.px(45),
                  height: Adapt.px(45),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: Adapt.px(10),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.info?.nickname ?? "",style: TextStyle(color: HexColor("#EEE4C1"),fontSize: TextSize.main1),),
                  SizedBox(height: Adapt.px(3),),
                  Row(
                    children: [
                      loadLocalImage("vip/vip_level_2",
                          width: Adapt.px(13),height: Adapt.px(13)),
                      Text(user.info?.roleText ?? "",style: TextStyle(color: HexColor("#EEE4C1"),fontSize: TextSize.main)),
                    ],
                  )
                ],
              )
            ],
          );
      },),
    );
  }
}