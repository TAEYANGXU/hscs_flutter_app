import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import '../model/article.dart';
import 'package:hscs_flutter_app/global_config.dart';

class VipArticleView extends StatefulWidget {
  VipArticleView({Key? key, this.articleList}) : super(key: key);
  List<VipArticleList>? articleList = [];

  _VipArticleViewState createState() => _VipArticleViewState();
}

class _VipArticleViewState extends State<VipArticleView> {

  Widget _cellForRow(BuildContext context, int index) {

    var model = widget.articleList![index];
    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.linkUrl});
      },
      child: Stack(
        children: [
          Container(
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
                      margin: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
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
          ),
          model.isNew! ? Container(
            margin: EdgeInsets.only(left:Adapt.px(200),top: Adapt.px(5)),
            child: loadLocalImage("vip/vip_article_new",
                width: Adapt.px(25), height: Adapt.px(17)),
          ) : Container(),
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
        itemCount: widget.articleList!.length,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
