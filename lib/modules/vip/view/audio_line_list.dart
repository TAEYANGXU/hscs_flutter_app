import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import '../model/audio.dart';

class AudioLineListView extends StatefulWidget {
  AudioLineListView({Key? key, this.audioList}) : super(key: key);
  List<AudioList>? audioList = [];

  _AudioLineListViewState createState() => _AudioLineListViewState();
}

class _AudioLineListViewState extends State<AudioLineListView> {
  Widget _cellForRow(BuildContext context, int index) {
    var model = widget.audioList![index];
    return GestureDetector(
      onTap: () async {
        // await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.linkUrl});
      },
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Adapt.px(90),
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(left: Adapt.px(15), right: Adapt.px(15)),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(15)),
                      child: loadLocalImage("vip/audio_play",
                          width: Adapt.px(7), height: Adapt.px(9)),
                    ),
                    SizedBox(
                      width: Adapt.px(5),
                    ),
                    Container(
                      height: Adapt.px(55),
                        margin: EdgeInsets.only(top: Adapt.px(10)),
                        width: Adapt.screenW() - Adapt.px(50),
                        child: Text(model.title ?? "",style: const TextStyle(fontSize: TextSize.main1),maxLines: 2,)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4,child: Container(
                      child: Row(
                        children: [
                          loadLocalImage("vip/audio_length",width: Adapt.px(13),height: Adapt.px(12)),
                          SizedBox(width: Adapt.px(5),),
                          Text(model.audioLength ?? "",style: TextStyle(color: AppColors.gredText),),
                        ],
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(model.zmtime ?? "",style: TextStyle(color: AppColors.gredText),),
                      ],
                    )
                  ],
                ),
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: Adapt.px(90), left: Adapt.px(15), right: Adapt.px(0)),
            height: Adapt.px(0.8),
            color: AppColors.line,
          ),
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
        itemCount: widget.audioList!.length,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
