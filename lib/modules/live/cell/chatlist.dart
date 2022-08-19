import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/index.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:provider/provider.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';

class ChatListCell extends StatefulWidget {
  ChatListCell({Key? key, this.model, this.showLeft = false}) : super(key: key);
  LiveList? model;
  bool showLeft;

  @override
  _ChatListCellState createState() => _ChatListCellState();
}

class _ChatListCellState extends State<ChatListCell> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      padding: EdgeInsets.only(bottom: Adapt.px(20)),
      child: Column(
        children: [
          widget.showLeft == true
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: Adapt.px(15), top: Adapt.px(0)),
                        child: ClipOval(
                          child: widget
                                  .model!.chatMsg!.userInfo!.avatar!.isEmpty
                              ? loadLocalImage("mine/mine_default_avatar",
                                  width: Adapt.px(40), height: Adapt.px(40))
                              : CacheImage(
                                  imageUrl:
                                      widget.model!.chatMsg!.userInfo!.avatar,
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
                        Container(
                          margin: EdgeInsets.only(top: Adapt.px(0)),
                          child: Text(
                            widget.model!.chatMsg!.userInfo!.nickname ?? "",
                            style: TextStyle(
                                color: AppColors.text,
                                fontSize: TextSize.big,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: Adapt.px(10),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: Adapt.px(50),
                            maxWidth: Adapt.screenW() - Adapt.px(120),
                            minHeight: Adapt.px(40),
                            // maxHeight: Adapt.px(9999),
                          ),
                          decoration: BoxDecoration(
                            color: HexColor("#F8E2C4"),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(Adapt.px(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget.model!.chatMsg!.content!,
                                    style: TextStyle(
                                        color: HexColor("#7A481D"),
                                        fontSize: TextSize.big),
                                  ),
                                ),
                                SizedBox(
                                  height: Adapt.px(5),
                                ),
                                widget.model!.chatMsg!.replyUserInfo != null
                                    ? Container(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Adapt.px(5),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: Adapt.px(10),
                                            right: Adapt.px(10)),
                                        height: Adapt.px(0.5),
                                        color: HexColor("#B5BFCF"),
                                      ),
                                      SizedBox(
                                        height: Adapt.px(5),
                                      ),
                                      Text(
                                          '${widget.model!.chatMsg!.replyUserInfo!.nickname!}：',
                                          style: TextStyle(
                                              color:
                                              HexColor("#5B8DFF"),
                                              fontSize: TextSize.big,
                                              fontWeight:
                                              FontWeight.bold)),
                                      SizedBox(
                                        height: Adapt.px(5),
                                      ),
                                      Text(
                                          widget
                                              .model!
                                              .chatMsg!
                                              .replyUserInfo!
                                              .replyComment!,
                                          style: TextStyle(
                                              color: AppColors.gredText,
                                              fontSize: TextSize.big)),
                                    ],
                                  ),
                                )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.model!.chatMsg!.userInfo!.nickname ?? "",
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontSize: TextSize.big,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Adapt.px(10),
                          ),
                          Consumer<UserInfo>(builder: (context, user, child) {
                            return Container(
                              // width: Adapt.screenW() - Adapt.px(100),
                              constraints: BoxConstraints(
                                minWidth: Adapt.px(50),
                                maxWidth: Adapt.screenW() - Adapt.px(120),
                              ),
                              decoration: BoxDecoration(
                                color: widget.model!.chatMsg!.userInfo!.uid == int.parse(user.info!.uid!) ? Colors.blue : HexColor("#F6F6F6"),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(Adapt.px(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.model!.chatMsg!.content!.trim(),
                                        style: TextStyle(
                                            color: AppColors.text,
                                            fontSize: TextSize.big),
                                        // textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Adapt.px(5),
                                    ),
                                    widget.model!.chatMsg!.replyUserInfo != null
                                        ? Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: Adapt.px(5),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: Adapt.px(10),
                                                      right: Adapt.px(10)),
                                                  height: Adapt.px(0.5),
                                                  color: HexColor("#B5BFCF"),
                                                ),
                                                SizedBox(
                                                  height: Adapt.px(5),
                                                ),
                                                Text(
                                                    '${widget.model!.chatMsg!.replyUserInfo!.nickname!}：',
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#5B8DFF"),
                                                        fontSize: TextSize.big,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  height: Adapt.px(5),
                                                ),
                                                Text(
                                                    widget
                                                        .model!
                                                        .chatMsg!
                                                        .replyUserInfo!
                                                        .replyComment!,
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.gredText,
                                                        fontSize:
                                                            TextSize.big)),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width: Adapt.px(0),
                                          ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Adapt.px(5),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            right: Adapt.px(15), top: Adapt.px(0)),
                        child: ClipOval(
                          child: widget
                                  .model!.chatMsg!.userInfo!.avatar!.isEmpty
                              ? loadLocalImage("mine/mine_default_avatar",
                                  width: Adapt.px(40), height: Adapt.px(40))
                              : CacheImage(
                                  imageUrl:
                                      widget.model!.chatMsg!.userInfo!.avatar,
                                  width: Adapt.px(40),
                                  height: Adapt.px(40),
                                ),
                        )),
                  ],
                )
        ],
      ),
    );
  }
}
