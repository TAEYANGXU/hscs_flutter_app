import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/global_config.dart';

class HomeSectionView extends StatelessWidget {
  HomeSectionView({Key? key, this.title = "", this.router = "",this.url})
      : super(key: key);

  String title;
  String router;
  String? url;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 7,
            //
            child: Container(
              padding: EdgeInsets.only(left: Adapt.px(12)),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: TextSize.larger,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            // padding: EdgeInsets.only(right: 0),
            child: GestureDetector(
              onTap: () async {
                print("更多");
                if(router == "webview"){
                  await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":url});
                }
              },
              child: Row(
                children: [
                  const Text(
                    '更多',
                    style: TextStyle(color: AppColors.orangeText),
                  ),
                  loadLocalImage("home_more_arrow",
                      width: Adapt.px(9), height: Adapt.px(14)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
