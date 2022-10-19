import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import '../model/home_article.dart';
import 'package:hscs_flutter_app/global_config.dart';

class TeacherArticleView extends StatefulWidget {
  TeacherArticleView({Key? key, this.articleList}) : super(key: key);
  List<ArticleData>? articleList = [];

  _TeacherArticleViewState createState() => _TeacherArticleViewState();
}

class _TeacherArticleViewState extends State<TeacherArticleView> {

  Widget _cellForRow(BuildContext context, int index) {

    var model = widget.articleList![index];
    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.linkUrl});
      },
      child: Stack(
        children: [
          Container(
            height: Adapt.px(100),
            width: double.infinity,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: Adapt.px(30),
                      child: Text(model.cTime ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
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
            margin: EdgeInsets.only(top: Adapt.px(100),left: Adapt.px(15),right: Adapt.px(0)),
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
        itemCount: widget.articleList!.length,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
