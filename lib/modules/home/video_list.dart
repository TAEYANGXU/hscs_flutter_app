import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/global_config.dart';

class VideoListPage extends StatefulWidget {

  VideoListPage({Key? key,this.type}) : super(key: key);
  String? type = "2";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoListPageState();
  }
}

class _VideoListPageState extends State<VideoListPage> {

  final HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getVideoListByType({"actType": widget.type,"page":1,"pageSize":20});
    await viewModel.getAD({"type":5});
    setState(() {

    });
  }

  Widget _cellForRow(BuildContext context, int index) {

    if(viewModel.adData != null && index == 0){
      return GestureDetector(
        onTap: () async {
          if(viewModel.adData!.linkUrl!.isNotEmpty){
            await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":viewModel.adData!.linkUrl});
          }
        },
        child: Container(
          height: Adapt.px(140),
          margin: EdgeInsets.all(Adapt.px(10)),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6)
          ),
          child: CacheImage(imageUrl: viewModel.adData!.imgUrl,width: Adapt.screenW() - Adapt.px(20),height: Adapt.px(140),),
        ),
      );
    }
    var model = viewModel.videoList[index - 1];
    return GestureDetector(
      onTap: () async {

      },
      child: Container(
        color: Colors.white,
        height: Adapt.px(100),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(10),bottom: Adapt.px(10)),
              width: Adapt.px(120),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Stack(
                children: [
                  CacheImage(imageUrl: model.vCoverImgUrl,width: Adapt.screenW() - Adapt.px(20),height: Adapt.px(140),),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(20),left: Adapt.px(40)),
                    height: Adapt.px(40),
                    width: Adapt.px(40),
                    // color: Colors.red,
                    child: Center(
                      child: loadLocalImage("home_video_play",width: Adapt.px(26),height: Adapt.px(26)),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(10)),
                  width: Adapt.screenW() - Adapt.px(30 + 120),
                  // height: Adapt.px(50),
                  child: Text(model.vTitle ?? "",
                    maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: TextSize.big,color: AppColors.text),
                  ),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(25 + 120),
                  padding: EdgeInsets.only(top: Adapt.px(5),left: Adapt.px(10)),
                  height: Adapt.px(40),
                  child: Text(model.vContent ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                ),
              ],
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
          "限时免费课",
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
          itemCount: viewModel.videoList.length + (viewModel.adData != null ? 1 : 0),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}