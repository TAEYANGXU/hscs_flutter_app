import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../../../extension/loading_icon.dart';
import '../model/article.dart';

class VipArticleHeaderView extends StatelessWidget {
  VipArticleHeaderView({Key? key, this.articleData}) : super(key: key);

  VipArticleData? articleData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          CacheImage(
            imageUrl: articleData!.coverPic ?? "",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          BackdropFilter(
            /// 过滤器
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            /// 必须设置一个空容器
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: Adapt.px(15),right: Adapt.px(15),top: Adapt.px(65)),
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
                          height: Adapt.px(145),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CacheImage(imageUrl: articleData!.coverPic,),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: Adapt.px(15),top: Adapt.px(95)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(articleData!.title ?? "",style: const TextStyle(fontSize: TextSize.larger,fontWeight: FontWeight.bold,color: Colors.white),),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: Adapt.px(10)),
                              width: Adapt.px(80),
                              height: Adapt.px(22),
                              decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(60),
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: const Center(
                                child: Text("栏目介绍",style: TextStyle(fontSize: TextSize.main1,fontWeight: FontWeight.bold,color: Colors.white),),
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: Adapt.px(10)),
                              child: Text(articleData!.description ?? "",style: const TextStyle(fontSize: TextSize.main,color: Colors.white),),
                            )
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(265)),
            width: double.infinity,
            height: Adapt.px(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
