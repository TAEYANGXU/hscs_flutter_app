import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:date_format/date_format.dart';

class VipReportView extends StatefulWidget {

  VipReportView({Key? key,this.reportList}) : super(key: key);

  List<AdvertListData>? reportList = [];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipReportViewState();
  }
}

class _VipReportViewState extends State<VipReportView> {

  Widget reportItem(int index){

    if(widget.reportList!.isEmpty){
      return Container();
    }
    var model = widget.reportList?[index];
    return Container(
      width: double.infinity,
      // height: Adapt.px(100),
      margin: EdgeInsets.all(Adapt.px(15)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Adapt.px(10)),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              offset: Offset(0, 4),
              blurRadius: 6,
              spreadRadius: 0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: Adapt.px(120),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: CacheImage(
                  imageUrl: model?.imgUrl ?? "",
                  width: double.infinity,
                  height: Adapt.px(120),
                ),
              ),
              Container(
                child: loadLocalImage("vip/vip_report",width: Adapt.px(72),height: Adapt.px(20)),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: Adapt.px(15),right: Adapt.px(15),top: Adapt.px(10)),
            child: Text(
              model?.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: TextSize.big,
                  color: AppColors.text,
                  fontWeight: FontWeight.w200),
            ),
          ),
          SizedBox(height: Adapt.px(6),),
          Container(
            margin: EdgeInsets.only(left: Adapt.px(15)),
            child: Row(
              children: [
                loadLocalImage("vip/vip_time",width: Adapt.px(12),height: Adapt.px(12)),
                SizedBox(width: Adapt.px(5),),
                Text(model?.createTime ?? ""),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 220,
      color: Colors.white,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext content, int index) {
          return reportItem(index);
        },
        itemCount: widget.reportList?.length,
        autoplay: true,
        autoplayDelay: 30000,
        // pagination: _buildPlugin(),
        onTap: (index) {
          print(" 点击 " + index.toString());
        },
        viewportFraction: 1,
        // autoplayDisableOnInteraction: true,
        // loop: true,
        scale: 1,
      ),
    );
  }
}