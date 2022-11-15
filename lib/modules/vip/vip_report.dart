import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/vip/service.dart';
import '../../extension/loading_icon.dart';
import '../../global_config.dart';
import '../../style/index.dart';
import '../../utils/index.dart';
import '../home/view/sudoku.dart';

class VipReportPage extends StatefulWidget
{
  const VipReportPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipReportPageState();
  }

}

class _VipReportPageState extends State<VipReportPage> {

  var viewModel = VipViewModel();

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getVipIconList({"tableId":3});
    await viewModel.getArticleAllList({"type":"2","page":1,"pageSize":20});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {

    if(index == 0){
      return Column(
        children: [
          HomeSudokuView(iconList: viewModel.iconList),
          Container(
            color: AppColors.line,
            width: double.infinity,
            height: Adapt.px(8),
          ),
        ],
      );
    }
    var model = viewModel.articleList![index-1];
    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.linkUrl});
      },
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Adapt.px(110),
            width: double.infinity,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      width: Adapt.screenW() - Adapt.px(190),
                      height: Adapt.px(20),
                      child: Text(model.title ?? "",
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: TextSize.big,color: AppColors.text,fontWeight: FontWeight.w600,),
                      ),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(125),
                      margin: EdgeInsets.only(top: Adapt.px(15),left: Adapt.px(15)),
                      height: Adapt.px(40),
                      child: Text(model.summary ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.text),maxLines: 2,overflow:TextOverflow.ellipsis),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(115),
                      margin: EdgeInsets.only(top: Adapt.px(5),left: Adapt.px(15)),
                      height: Adapt.px(20),
                      child: Text(model.cTime ??="",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                    ),
                  ],
                ),
                SizedBox(width: Adapt.px(0),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: model.coverPic!.isNotEmpty ? CacheImage(imageUrl: model.coverPic ??="",width: Adapt.px(90),height: Adapt.px(70),) : Container(),
                    )
                  ],
                ) ,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(110),left: Adapt.px(15),right: Adapt.px(0)),
            height: Adapt.px(0.8),
            color: AppColors.line,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      child: ListView.builder(
        itemBuilder: _cellForRow,
        itemCount: viewModel.articleList!.length + 1,
        padding: EdgeInsets.zero,
      ),
    );
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Container(
  //     color: Colors.white,
  //     child: SingleChildScrollView(
  //       physics: const BouncingScrollPhysics(),
  //       padding: const EdgeInsets.all(0),
  //       child: Column(
  //         children: [
  //           HomeSudokuView(iconList: viewModel.iconList),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
