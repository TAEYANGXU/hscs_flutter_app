import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/index.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class LiveListCell extends StatefulWidget {
  LiveListCell({Key? key, this.model}) : super(key: key);
  LiveList? model;

  @override
  _LiveListCellState createState() => _LiveListCellState();
}

class _LiveListCellState extends State<LiveListCell> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      padding: EdgeInsets.only(bottom: Adapt.px(15)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: Adapt.px(15), top: Adapt.px(0)),
                  // clipBehavior: Clip.hardEdge,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(Adapt.px(20))
                  // ),
                  child: ClipOval(
                    child: CacheImage(
                      imageUrl: widget.model!.liveMsg!.teacher!.avatar,
                      width: Adapt.px(40),
                      height: Adapt.px(40),
                    ),
                  )),
              SizedBox(
                width: Adapt.px(5),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.model!.liveMsg!.teacher!.nickname ?? "",
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: TextSize.big,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Adapt.px(10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor("EE6823"),
                            borderRadius: BorderRadius.circular(3)),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Adapt.px(5), right: Adapt.px(5)),
                          child: Center(
                            child: Text(
                              widget.model!.liveMsg!.teacher!.title ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.small),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Adapt.px(5),
                  ),
                  Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(right: Adapt.px(30)),
                        width: Adapt.screenW() - Adapt.px(120),
                        decoration: BoxDecoration(
                            color: HexColor("#F8E2C4"),
                            borderRadius: BorderRadius.circular(6)
                            // image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //     image:AssetImage('lib/assets/image/live/live_cell_bg.png',),
                            // )
                            ),
                        child: Column(
                          children: [
                            Html(
                              data: widget.model!.liveMsg!.richContent == null
                                  ? ""
                                  : "<p>${widget.model!.liveMsg!.richContent!}<\/p>",
                              style: {
                                'h5': Style(
                                    fontSize: FontSize.large,
                                    color: AppColors.text),
                                'p': Style(
                                    fontSize: FontSize.large,
                                    color: AppColors.text),
                                'br': Style(
                                    fontSize: FontSize.large,
                                    color: AppColors.text),
                                'b': Style(
                                    fontSize: FontSize.large,
                                    color: AppColors.text),
                              },
                              onLinkTap: (url, _, __, ___) {
                                print("Opening $url...");
                              },
                            ),
                            widget.model!.liveMsg!.pics!.length == 0
                                ? Container()
                                : Container(
                              margin: EdgeInsets.only(left: Adapt.px(10),bottom: Adapt.px(10),right: Adapt.px(10)),
                              height: Adapt.px(120),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: CacheImage(
                                imageUrl: widget.model!.liveMsg!.pics![0],
                                height: Adapt.px(120),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
