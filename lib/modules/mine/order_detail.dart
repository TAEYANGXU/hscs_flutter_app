import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/mine/model/index.dart';
import 'service.dart';
import '../../style/index.dart';
import '../../utils/index.dart';
import 'dart:convert';

class MineOrderDetailPage extends StatefulWidget {
  MineOrderDetailPage({Key? key, this.order}) : super(key: key);
  String? order;

  @override
  State<StatefulWidget> createState() => _MineOrderDetailPageState();
}

class _MineOrderDetailPageState extends State<MineOrderDetailPage> {
  var viewModel = MineViewModel();
  OrderData? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var orderDict = json.decode(widget.order!);
    model = OrderData.fromJson(orderDict);
    print('${orderDict}');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: HexColor("#FAFAFA"),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "订单详情",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Adapt.px(15),left: Adapt.px(15),right: Adapt.px(15)),
            height: Adapt.px(35 * 8) + Adapt.px(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Adapt.px(35),
                  child: const Center(
                    child: Text('花生服务尊享会员',style: TextStyle(fontSize: TextSize.larger,fontWeight: FontWeight.w600),),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("商品名称：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.goodsName}",style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Adapt.px(10),right: Adapt.px(10)),
                      color: HexColor("#F0F0F0"),
                      height: Adapt.px(1),
                      // width: double.infinity,
                    ),
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("订单号：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.outTradeNo}",style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Adapt.px(10),right: Adapt.px(10)),
                      color: HexColor("#F0F0F0"),
                      height: Adapt.px(1),
                      // width: double.infinity,
                    ),
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("VIP等级：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.level}",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#998154")),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Adapt.px(10),right: Adapt.px(10)),
                      color: HexColor("#F0F0F0"),
                      height: Adapt.px(1),
                      // width: double.infinity,
                    ),
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("商品价格：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.realAmount}",style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("已付金额：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.subPayedAmount}",style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("到期时间：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.payedAt}",style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Adapt.px(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: Adapt.px(10),),
                          Container(
                            margin: EdgeInsets.only(left: Adapt.px(10)),
                            child: Text("订单状态：",style: TextStyle(fontSize: TextSize.main1,color: HexColor("#999999")),),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Adapt.px(10)),
                            child: Text("${model?.statusText}",style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),),
                          )
                          // SizedBox(width: Adapt.px(10),),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Adapt.px(60),),
          Container(
            width: Adapt.px(200),
            height: Adapt.px(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(colors: [HexColor("#FFAB1A"),HexColor("#FC830B"),HexColor("#FA6A02")],
                  begin: Alignment.topRight,end: Alignment.bottomRight,),
            ),
            child: const Center(child: Text("开发票",style: TextStyle(color: Colors.white,fontSize: TextSize.larger),),),
          )
        ],
      ),
    );
  }
}
