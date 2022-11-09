import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import '../router.dart';

class LiveTopView extends StatefulWidget{
  LiveTopView({Key? key,this.room}) : super(key: key);
  RoomInfo? room;
  @override
  _LiveTopViewState createState() => _LiveTopViewState();
}

class _LiveTopViewState extends State<LiveTopView>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      // width: double.infinity,
      height: Adapt.px(30),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: Adapt.px(0)),
            child: Row(
              children: [
                loadLocalImage("live/live_vip",width: Adapt.px(16),height: Adapt.px(14)),
                SizedBox(width: Adapt.px(5),),
                Text(widget.room!.roomName ?? "",style: const TextStyle(fontSize: TextSize.s17,fontWeight: FontWeight.w600,color: AppColors.text),)
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              print("搜索");
              String roomId = '${widget.room!.roomId!}';
              Routers.push(context, LiveRouter.search,params: {"roomId":roomId});
            },
            child: Container(
              margin: EdgeInsets.only(right: Adapt.px(0)),
              height: Adapt.px(28),
              width: Adapt.screenW() - Adapt.px(150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: HexColor("#CCCCCC"),width: Adapt.px(1)),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Adapt.px(5)),
                    child: loadLocalImage("live/live_search",width: Adapt.px(16),height: Adapt.px(16)),
                  ),
                  SizedBox(width: Adapt.px(5),),
                  const Text("搜搜你关心的内容吧~",style: TextStyle(color: AppColors.gredText,fontSize: TextSize.main),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}