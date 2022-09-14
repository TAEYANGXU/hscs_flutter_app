import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/mine/router.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'package:hscs_flutter_app/routers.dart';

class MineCouponPage extends StatefulWidget {
  MineCouponPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineCouponPageState();
}

class _MineCouponPageState extends State<MineCouponPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getCouponList({});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.couponList[index];
    return GestureDetector(
      onTap: (){
        print("object");
          if(model.type == 1){
            Routers.push(context, MineRouter.discount,params: {"type":'${model.type}'});
          }
          if(model.type == 2){
            Routers.push(context, MineRouter.card,params: {"type":'${model.type}'});
          }
      },
      child: Container(
        margin: EdgeInsets.only(top: Adapt.px(15),left: Adapt.px(15),right: Adapt.px(15)),
        height: Adapt.px(88),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(model.type == 1 ? 'lib/assets/image/mine/coupon_dis_bg.png' : 'lib/assets/image/mine/coupon_card_bg.png'))
        ),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: Adapt.px(85),
                  child: Center(child: loadLocalImage(model.type == 1 ? "/mine/coupon_dis_icon" : "/mine/coupon_card_icon",width: Adapt.px(48), height: Adapt.px(48)),),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name ?? "",style: const TextStyle(fontSize: TextSize.larger,fontWeight: FontWeight.w600),),
                    SizedBox(height: Adapt.px(5),),
                    Text("${model.amount}${model.unit}",style: const TextStyle(fontSize: TextSize.main)),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: Adapt.screenW() - Adapt.px(80)),
              width: Adapt.px(24),
              height: Adapt.px(88),
              child: loadLocalImage("/mine/coupon_arrown",width: Adapt.px(24),height: Adapt.px(24)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "卡券包",
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
          itemCount: viewModel.couponList.length,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}