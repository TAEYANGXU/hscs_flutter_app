import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';

class MineOtherModel {
  final String icon;
  final String name;
  final String router;

  MineOtherModel(this.icon, this.name, this.router);
}

List<MineOtherModel> list = [
  MineOtherModel("mine/mine_item_5", "意见反馈", "1"),
  MineOtherModel("mine/mine_item_6", "关于我们", "2"),
];

class MineOtherView extends StatefulWidget {
  MineOtherView({Key? key}) : super(key: key);

  _MineOtherViewState createState() => _MineOtherViewState();
}

class _MineOtherViewState extends State<MineOtherView> {
  @override
  Widget build(BuildContext context) {
    Widget _cellForRow(BuildContext content, int index) {
      return Container(
        width: double.infinity,
        height: Adapt.px(40),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Adapt.px(20)),
                      child: localImage(list[index].icon,width: Adapt.px(16),height: Adapt.px(16),fit: BoxFit.contain),
                    ),
                    SizedBox(width: Adapt.px(10),),
                    Text(list[index].name,style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                    SizedBox(width: Adapt.px(230),),
                    loadLocalImage("mine/mine_arrown_right",
                        width: Adapt.px(9), height: Adapt.px(16))
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: Adapt.px(40),top: Adapt.px(39)),
              width: Adapt.screenW() - Adapt.px(60),
              height: Adapt.px(2),
              color: AppColors.space,
            )
          ],
        ),
      );
    }

    // TODO: implement build
    return Container(
      width: double.infinity,
      height: Adapt.px(400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Adapt.px(35),
            padding: EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(10)),
            child: Text(
              "其他",
              style: TextStyle(
                  fontSize: TextSize.s17,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            height: Adapt.px(80),
            child: ListView.builder(
              itemBuilder: _cellForRow,
              itemCount: list.length,
              padding: EdgeInsets.zero,
            ),
          ),

        ],
      ),
    );
  }
}
