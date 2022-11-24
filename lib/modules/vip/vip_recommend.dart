import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/vip/router.dart';
import 'package:hscs_flutter_app/modules/vip/view/index.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/modules/home/view/sudoku.dart';
import 'package:hscs_flutter_app/modules/vip/model/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/routers.dart';

class VipRecommendPage extends StatefulWidget {

  VipRecommendPage({Key? key,this.iconList,this.reportList,this.audio,this.liveData,this.columnList}) : super(key: key);

  List<IconList>? iconList = [];
  List<AdvertListData>? reportList = [];
  AudioList? audio;
  LiveVideoData?  liveData;
  List<ListData>? columnList;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipRecommendPageState();
  }
}

class _VipRecommendPageState extends State<VipRecommendPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            HomeSudokuView(iconList: widget.iconList ?? []),
            VipReportView(reportList: widget.reportList ?? []),
            VipAudioView(audio: widget.audio,),
            VipLiveView(liveData: widget.liveData,),
            VipColumnView(columnList: widget.columnList,callback: (String str){
              print("${str}");
            },),
            GestureDetector(
              onTap: (){
                Routers.push(context, VipRouter.vipArticleList);
              },
              child: Container(
                color: Colors.white,
                height: Adapt.px(50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("查看全部",style: TextStyle(color: AppColors.orangeText,fontSize: TextSize.main),),
                    SizedBox(width: Adapt.px(6),),
                    loadLocalImage("home_more_arrow",
                        width: Adapt.px(9), height: Adapt.px(14)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}