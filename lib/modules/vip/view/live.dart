import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hscs_flutter_app/modules/vip/model/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'section.dart';
import 'package:date_format/date_format.dart';
import 'package:hscs_flutter_app/global_config.dart';

class VipLiveView extends StatefulWidget {

  VipLiveView({Key? key,this.liveData}) : super(key: key);

  LiveVideoData?  liveData;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipLiveViewState();
  }
}

class _VipLiveViewState extends State<VipLiveView> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: Adapt.px(10),),
          VipSectionView(title: "投资有道",icon: "vip/vip_section_2",),
          GestureDetector(
            onTap: () async {

              var res = await GlobalConfig.channel.invokeMethod("lyitp://diqiu/live_video",{"roomId":widget.liveData?.roomId});
              print("访问swift = ${res}");

            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: Adapt.px(180),
              margin: EdgeInsets.all(Adapt.px(15)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: widget.liveData?.listCoverPic != null ? DecorationImage(image: NetworkImage(widget.liveData?.listCoverPic ?? ""),fit: BoxFit.cover) : null,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: Adapt.px(50),
                        height: Adapt.px(30),
                        color: HexColor("#EDD3AA"),
                        child: Center(child: Text("预告",style: TextStyle(color: HexColor("#8D774A")),),),
                      ),
                      Container(
                        width: Adapt.px(100),
                        height: Adapt.px(30),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8)
                          ),
                          color: HexColor("#565861"),
                        ),
                        child: Center(
                          child: Text( widget.liveData?.startTimeStamp != null ? formatDate(
                              DateTime.fromMillisecondsSinceEpoch(widget.liveData!.startTimeStamp!*1000),
                              [mm, '-', dd, ' ', HH, ':', nn])  : "",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: Adapt.px(30),
                    margin: EdgeInsets.only(top: Adapt.px(105)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Adapt.px(15)),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Adapt.px(15)),
                              ),
                              child: widget.liveData?.teachers![0].avatar != null ? CacheImage(imageUrl: widget.liveData?.teachers![0].avatar ?? "",width: Adapt.px(30),height: Adapt.px(30),) : Container(),
                            ),
                            SizedBox(width: Adapt.px(5),),
                            Text( widget.liveData?.teachers![0].nickName ?? "",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: Adapt.px(15)),
                          child: loadLocalImage("vip/vip_live_state_1",width: Adapt.px(82),height: Adapt.px(23)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}