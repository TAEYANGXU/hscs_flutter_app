import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/audio.dart';
import 'section.dart';
import '../router.dart';

class VipAudioView extends StatefulWidget {

  VipAudioView({Key? key,this.audio}) : super(key: key);

  AudioList? audio;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipAudioViewState();
  }
}

class _VipAudioViewState extends State<VipAudioView> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(widget.audio == null){
      return Container();
    }
    print("audio!.toJson = ${widget.audio!.toJson()}");
    var actId =  widget.audio!.actId ?? 36;
    return Container(
      height: Adapt.px(161),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Adapt.px(8),
            color: AppColors.space,
          ),
          SizedBox(height: Adapt.px(10),),
          VipSectionView(icon: "vip/vip_section_1",title: "首席之声",router: VipRouter.audioLine,params: {"actId":'$actId'},),
          Container(
            width: double.infinity,
            height: Adapt.px(110),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Adapt.px(15)),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: loadLocalImage("vip/vip_xjy",width: Adapt.px(70),height: Adapt.px(70),)
                ),
                SizedBox(width: Adapt.px(10),),
                Container(
                  width: Adapt.screenW() - Adapt.px(120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: Adapt.px(15)),
                        child: Text(widget.audio?.title ?? "",maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ),
                      SizedBox(height: Adapt.px(15),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.audio?.zmtime ?? ""),
                          loadLocalImage("vip/vip_audio_play",width: Adapt.px(79),height: Adapt.px(22))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: Adapt.px(8),
            color: AppColors.space,
          ),
        ],
      ),
    );
  }
}