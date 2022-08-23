import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/web/router.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../model/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:date_format/date_format.dart';
import 'package:hscs_flutter_app/routers.dart';

class ResearchPage extends StatefulWidget {
  ResearchPage({Key? key, this.list}) : super(key: key);
  List<ResearchList>? list;

  @override
  _ResearchPageState createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  Widget _cellForRow(BuildContext context, int index) {
    var model = widget.list![index];

    return GestureDetector(
      onTap: () {
        Routers.push(context, WebViewRouter.webView,
            params: {"url": model.detailLink});
      },
      child: Container(
        width: double.infinity,
        // height: Adapt.px(100),
        margin: EdgeInsets.all(Adapt.px(15)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Adapt.px(10)),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: Adapt.px(140),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: CacheImage(
                imageUrl: model.coverImage,
                width: double.infinity,
                height: Adapt.px(140),
              ),
            ),
            Container(
              margin: EdgeInsets.all(Adapt.px(15)),
              child: Text(
                model.title!,
                style: const TextStyle(
                    fontSize: TextSize.big,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: Adapt.px(15)),
                      // child: Text(model.createdAt! ?? ""),
                      child: Text(formatDate(
                              DateTime.fromMillisecondsSinceEpoch(
                                  model.createTime! * 1000),
                              [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn])),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: const Text(
                            "查看详情",
                            style: TextStyle(color: AppColors.theme),
                          ),
                        ),
                        SizedBox(
                          width: Adapt.px(15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Adapt.px(10),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        itemBuilder: _cellForRow,
        itemCount: widget.list != null ? widget.list!.length : 0,
      ),
    );
  }
}
