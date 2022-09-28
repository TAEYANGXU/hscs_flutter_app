import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../model/integral.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';

class IntegralListView extends StatefulWidget {
  IntegralListView({Key? key, this.integralList}) : super(key: key);
  List<IntegralData>? integralList = [];

  _IntegralListViewState createState() => _IntegralListViewState();
}

class _IntegralListViewState extends State<IntegralListView> {
  List<Widget> getItems() {
    List<Widget> list = [];
    for (var i = 0; i < widget.integralList!.length; i++) {
      var icon = widget.integralList![i];
      list.add(buildItem(context, i));
    }
    return list;
  }

  Widget buildItem(BuildContext context, int index) {
    var model = widget.integralList![index];
    return GestureDetector(
        onTap: () {
          debugPrint("index = $index");
        },
        child: Container(
          margin: index%2 == 0
              ? EdgeInsets.only(top: Adapt.px(0),left: Adapt.px(15),right: Adapt.px(10),bottom: Adapt.px(0))
              : EdgeInsets.only(top: Adapt.px(0),left: Adapt.px(10),right: Adapt.px(15),bottom: Adapt.px(0)) ,
          width: Adapt.px(155),
          height: Adapt.px(100),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Adapt.px(15)),
                width: double.infinity,
                height: Adapt.px(150),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        offset: const Offset(0, 1),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Adapt.px(15)),
                width: Adapt.px(118),
                height: Adapt.px(75),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6)
                ),
                child: CacheImage(imageUrl: model.goodsImg,width: Adapt.px(118),height: Adapt.px(75)),
              ),
              Container(
                margin: EdgeInsets.only(top: Adapt.px(85),left: Adapt.px(15)),
                width: double.infinity,
                height: Adapt.px(80),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text("${model.name}",style: TextStyle(fontSize: TextSize.minor,fontWeight: FontWeight.w600),),
                    SizedBox(height: Adapt.px(5),),
                    Text("${model.price}积分",style: TextStyle(color: HexColor("#FB7204")),),
                    SizedBox(height: Adapt.px(5),),
                    Container(
                      child: int.parse(model.goodsNumber!) > 0 ?
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("剩余${model.goodsNumber ?? ""}"),
                            Container(
                              padding: EdgeInsets.only(right: Adapt.px(15)),
                              child: Text("限兑${model.limitAmount}件",style: TextStyle(color: HexColor("#666666")),),
                            )
                          ],
                        ),
                      ) :
                      SizedBox(
                        child: const Text("抢完了，下次再来吧"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  double getHeight() {
    var size = widget.integralList!.length;
    var col = widget.integralList!.length / 2;
    if (widget.integralList!.length % 2 > 0) {
      col += 1;
    }
    print("col = $col");
    print("size = $size");
    return col * Adapt.px(150) + Adapt.px(30);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: getHeight(),
      color: HexColor("#F7F7F7"),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        children: getItems(),
        // scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 10),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
