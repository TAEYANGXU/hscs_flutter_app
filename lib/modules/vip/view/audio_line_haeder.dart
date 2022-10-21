import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/vip/model/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../../../extension/loading_icon.dart';

class AudioLineHeaderView extends StatelessWidget {
  AudioLineHeaderView({Key? key, this.actInfoData}) : super(key: key);

  ActInfoData? actInfoData;

  @override
  Widget build(BuildContext context) {

    if(actInfoData == null){
      return Container();
    }

    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.yellow,
            height: Adapt.px(150),
            child: CacheImage(imageUrl: actInfoData!.surfaceimg,width: double.infinity,),
          ),
          Container(
            margin: EdgeInsets.only(left: Adapt.px(15),top: Adapt.px(100)),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2)
            ),
            child: Text(actInfoData!.actTime ?? "",style: const TextStyle(color: Colors.white,fontSize: TextSize.main),),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(130),left: Adapt.px(15),right: Adapt.px(15),),
            height: Adapt.px(110),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  offset: const Offset(0, 2),
                  blurRadius: 12,
                  spreadRadius: 0,
                )
              ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(130),left: Adapt.px(30),right: Adapt.px(15),),
            height: Adapt.px(120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Adapt.px(15),),
                Text(actInfoData!.name ?? "",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: TextSize.big),),
                SizedBox(height: Adapt.px(5),),
                Text(actInfoData!.description ?? "",style: const TextStyle(fontWeight: FontWeight.w300,fontSize: TextSize.main,color: AppColors.gredText),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    loadLocalImage("vip/vip_audio_icon",width: Adapt.px(16),height: Adapt.px(16)),
                    SizedBox(width: Adapt.px(5),),
                    Text(actInfoData!.audioTile ?? "",style: const TextStyle(fontWeight: FontWeight.w300,fontSize: TextSize.minor)),
                    SizedBox(width: Adapt.px(5),),
                    const Text("·",style: TextStyle(fontWeight: FontWeight.bold,fontSize: TextSize.big),),
                    SizedBox(width: Adapt.px(5),),
                    Text(actInfoData!.audioDes ?? "",style: const TextStyle(fontWeight: FontWeight.w300,fontSize: TextSize.minor,color: AppColors.gredText)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(250),left: Adapt.px(0)),
            height: Adapt.px(40),
            // color: Colors.red,
            width: Adapt.screenW()/2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Adapt.px(6),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("目录",style: TextStyle(fontWeight: FontWeight.w500,fontSize: TextSize.s20),),
                    Text("共794讲",style: TextStyle(fontWeight: FontWeight.w300,fontSize: TextSize.big,color: AppColors.gredText),),
                  ],
                ),
                SizedBox(height: Adapt.px(2),),
                Container(
                  margin: EdgeInsets.only(left: Adapt.px(60)),
                  width: Adapt.px(12),
                  height: Adapt.px(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(1.5)
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(288)),
            width: double.infinity,
            height: Adapt.px(1),
            color: AppColors.line,
          )
        ],
      ),
    );
  }
}
