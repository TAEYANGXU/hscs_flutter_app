import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/modules/login/router.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import '../router.dart';

const List<String> titleList = ["我的资产", "我的消息", "卡券包", "购买记录"];
const List<String> iconList = [
  "mine/mine_item_1",
  "mine/mine_item_2",
  "mine/mine_item_3",
  "mine/mine_item_4"
];

class MineHeadView extends StatefulWidget {
  MineHeadView({Key? key}) : super(key: key);

  _MineHeadViewState createState() => _MineHeadViewState();
}

class _MineHeadViewState extends State<MineHeadView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> getListItem() {
      List<Widget> list = [];
      for (int i = 0; i < titleList.length; i++) {
        var title = titleList[i];
        list.add(Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  height: Adapt.px(10),
                ),
                Image.asset(
                  "lib/assets/image/${iconList[i]}.png",
                  width: Adapt.px(24),
                  height: Adapt.px(24),
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: Adapt.px(5),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: TextSize.main, color: AppColors.text2),
                ),
              ],
            )));
      }
      return list;
    }

    String getLevelIcon(int role){
      String icon = "mine/user_level_5";
      switch(role){
        case 100:
          icon = "mine/user_level_6";
          break;
        case 125:
          icon = "mine/user_level_1";
          break;
        case 150:
          icon = "mine/user_level_2";
          break;
        case 200:
          icon = "mine/user_level_3";
          break;
        case 300:
          icon = "mine/user_level_4";
          break;
      }
      return icon;
    }

    // TODO: implement build
    return Container(
      width: double.infinity,
      height: Adapt.px(300),
      child: Consumer<UserInfo>(builder: (context, user, child) {
        return Stack(
          children: [
            Container(
              height: Adapt.px(190),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: user.info != null ? AssetImage('lib/assets/image/mine/mine_logined_bg.png')
                        : AssetImage('lib/assets/image/mine/mine_login_bg.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Adapt.screenW() - Adapt.px(30) - Adapt.px(10),
                  top: Adapt.px(65)),
              width: Adapt.px(30),
              height: Adapt.px(30),
              child: GestureDetector(
                onTap: (){
                  Routers.push(context, MineRouter.setting);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: Adapt.px(20),
                  height: Adapt.px(20),
                  child: loadLocalImage("mine/mine_setting_white",
                      width: Adapt.px(20), height: Adapt.px(20)),
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    if(user.info == null){
                      Routers.push(context, LoginRouter.login,settings: const RouteSettings(name: MineRouter.mine));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            offset: Offset(0, 2),
                            blurRadius: 8,
                            spreadRadius: 0,
                          )
                        ]),
                    height: Adapt.px(100),
                    margin: EdgeInsets.only(
                        left: Adapt.px(10),
                        right: Adapt.px(10),
                        top: Adapt.px(110)),
                    child: Row(
                      children: [
                        Container(

                          width: Adapt.px(60),
                          height: Adapt.px(60),
                          margin: EdgeInsets.only(left: Adapt.px(10)),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Adapt.px(30))
                          ),
                          child: user.info == null ? loadLocalImage("mine/mine_default_avtar",
                              width: Adapt.px(60),height: Adapt.px(60)) :
                          CacheImage(
                            imageUrl: user.info!.avatar ?? "",
                            width: Adapt.px(60),
                            height: Adapt.px(60),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: Adapt.px(10),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user.info != null ? user.info!.nickname! : "登陆丨注册",
                                  style: TextStyle(
                                      fontSize: TextSize.s17,
                                      color: AppColors.text),
                                ),
                                SizedBox(
                                  width: Adapt.px(5),
                                ),
                                Container(
                                  width: Adapt.px(69),
                                  height: Adapt.px(17),
                                  child: user.info != null ?  loadLocalImage(getLevelIcon(user.info!.role!),
                                      width: Adapt.px(69), height: Adapt.px(17)) : Container(),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Adapt.px(3),
                            ),
                            user.info != null ? Text( user.info != null ? user.info!.vipExpireDay! : "",
                                style: TextStyle(
                                    fontSize: TextSize.main1,
                                    color: AppColors.text2)) : Container(height: 0,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: Adapt.px(90),
                            ),
                            Container(
                              width: Adapt.px(9),
                              height: Adapt.px(16),
                              child: loadLocalImage("mine/mine_arrown_right",
                                  width: Adapt.px(9), height: Adapt.px(16)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Adapt.px(10)),
                  // color: Colors.yellow,
                  width: double.infinity,
                  height: Adapt.px(70),
                  child: Row(
                    children: getListItem(),
                  ),
                ),
                Container(
                  height: Adapt.px(6),
                  width: double.infinity,
                  color: AppColors.space,
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
