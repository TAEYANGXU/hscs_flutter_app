import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';

class MineActivityView extends StatefulWidget {
  MineActivityView({Key? key}) : super(key: key);

  _MineActivityViewState createState() => _MineActivityViewState();
}

class _MineActivityViewState extends State<MineActivityView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: Adapt.px(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(10)),
            child: Text(
              "活动",
              style: TextStyle(
                  fontSize: TextSize.s17,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            height: Adapt.px(60),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: Adapt.px(20), top: Adapt.px(10)),
                          child: Row(
                            children: [
                              loadLocalImage("mine/mine_activity_1",
                                  width: Adapt.px(16), height: Adapt.px(20)),
                              SizedBox(
                                width: Adapt.px(2),
                              ),
                              Text(
                                "邀请我的好友",
                                style: TextStyle(
                                    fontSize: TextSize.s17,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.text),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: Adapt.px(40), top: Adapt.px(2)),
                          child: Text("和好友一起理财",
                              style: TextStyle(
                                  fontSize: TextSize.main,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.gredText)),
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: Adapt.px(20), top: Adapt.px(10)),
                          child: Row(
                            children: [
                              loadLocalImage("mine/mine_activity_2",
                                  width: Adapt.px(13), height: Adapt.px(14)),
                              SizedBox(
                                width: Adapt.px(2),
                              ),
                              Text(
                                "积分兑好礼",
                                style: TextStyle(
                                    fontSize: TextSize.s17,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.text),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: Adapt.px(34), top: Adapt.px(2)),
                          child: Text("各类好礼等你来拿",
                              style: TextStyle(
                                  fontSize: TextSize.main,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.gredText)),
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
