import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/vip/view/index.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/modules/home/view/sudoku.dart';
import 'package:hscs_flutter_app/modules/vip/model/index.dart';
import 'view/report.dart';

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
            VipColumnView(columnList: widget.columnList,),
          ],
        ),
      ),
    );
  }
}