import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/mine/model/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'service.dart';
import 'router.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'dart:convert';

class MineOrderPage extends StatefulWidget {
  MineOrderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineOrderPageState();
}

class _MineOrderPageState extends State<MineOrderPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.orderList({});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.orderArray[index];
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: Adapt.px(20),
          ),
          Container(
            padding: EdgeInsets.only(left: Adapt.px(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CacheImage(
                    imageUrl: model.image,
                    width: Adapt.px(90),
                    height: Adapt.px(110),
                  ),
                ),
                SizedBox(
                  width: Adapt.px(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.goodsName ?? "",
                      style: TextStyle(
                          fontSize: TextSize.larger,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: Adapt.px(5),
                    ),
                    Container(
                      height: Adapt.px(28),
                      decoration: BoxDecoration(
                          color: HexColor("#FFF7E9"),
                          border:
                              Border.all(width: 1, color: HexColor("#D7A859")),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          '  ${model.tagText ?? ""}  ',
                          style: TextStyle(fontSize: TextSize.big),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Adapt.px(5),
                    ),
                    Text(
                      '${model.realAmount ?? ""}元',
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                    SizedBox(
                      height: Adapt.px(5),
                    ),
                    Row(
                      children: [
                        Text('购买时间：${model.payedAt}',
                            style: TextStyle(
                                fontSize: TextSize.big,
                                color: HexColor("#B0B2BE"))),
                        SizedBox(
                          width: Adapt.px(20),
                        ),
                        Text(
                            (model.status == 40 || model.status == 36)
                                ? model.statusText ?? ""
                                : "已过期",
                            style: TextStyle(
                                fontSize: TextSize.big,
                                color:
                                    (model.status == 40 || model.status == 36)
                                        ? AppColors.text
                                        : Colors.red)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: Adapt.px(20),
          ),
          Container(
            color: AppColors.line,
            height: Adapt.px(1),
            width: double.infinity,
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  print("查看详情");
                  var order = model.toJson();
                  Routers.push(context, MineRouter.orderDetail,
                      params: {"order": json.encode(order)});
                },
                child: Container(
                  margin: EdgeInsets.only(right: Adapt.px(15)),
                  width: Adapt.px(90),
                  height: Adapt.px(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: HexColor("#FB6700")),
                      borderRadius: BorderRadius.circular(Adapt.px(15))),
                  child: Center(
                    child: Text(
                      "查看详情",
                      style: TextStyle(
                          fontSize: TextSize.big, color: HexColor("#FB6700")),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
            width: double.infinity,
            height: Adapt.px(10),
            color: AppColors.space,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "购买记录",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SizedBox(
        child: ListView.builder(
          itemBuilder: _cellForRow,
          itemCount: viewModel.orderArray.length,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
