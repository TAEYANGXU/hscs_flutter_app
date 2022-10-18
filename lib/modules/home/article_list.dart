
import 'package:flutter/material.dart';
import '../../extension/loading_icon.dart';
import '../../style/index.dart';
import '../../utils/index.dart';
import 'service.dart';
import 'view/headline_top.dart';
import 'package:hscs_flutter_app/global_config.dart';

class ArticleListPage extends StatefulWidget{

  ArticleListPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ArticleListPageState();
  }
}

class _ArticleListPageState extends State<ArticleListPage>{

  final viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getHeadlineTop();
    await viewModel.getHeadlineList({"page": 1,"pageSize": 20});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    if(index == 0 && viewModel.headLineTopList!.isNotEmpty){
      return HeadLineTopView(headLineList: viewModel.headLineTopList,);
    }
    if(viewModel.headLineList!.isEmpty){
      return Container();
    }
    var model = viewModel.headLineList![(viewModel.headLineTopList!.isNotEmpty ? index - 1 : index)];
    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.detailLink});
      },
      child: Stack(
        children: [
          Container(
            height: Adapt.px(110),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Adapt.px(15),left: Adapt.px(15)),
                      width: Adapt.screenW() - Adapt.px(115),
                      height: Adapt.px(65),
                      child: Text(model.title ?? "",
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: TextSize.main1,color: AppColors.text,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(115),
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      height: Adapt.px(40),
                      child: Text(model.createdAt ?? "",style: TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                    ),
                  ],
                ),
                SizedBox(width: Adapt.px(10),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: model.coverPic!.isNotEmpty ? CacheImage(imageUrl: model.coverPic ?? "",width: Adapt.px(90),height: Adapt.px(70),) : Container(),
                    )
                  ],
                ) ,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(109),left: Adapt.px(15),right: Adapt.px(0)),
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
          "理财头条",
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
          itemCount: viewModel.headLineTopList!.isNotEmpty ? viewModel.headLineList!.length + 1 : viewModel.headLineList!.length,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}