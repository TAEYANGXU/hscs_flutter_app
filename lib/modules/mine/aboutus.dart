import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/modules/web/router.dart';

class MineAboutUsPage extends StatefulWidget {
  MineAboutUsPage({Key? key, this.type}) : super(key: key);
  int? type;

  @override
  State<StatefulWidget> createState() => _MineAboutUsPageState();
}

class _MineAboutUsPageState extends State<MineAboutUsPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel
        .getCouponDetailList({"type": widget.type, "page": 1, "pageSize": 20});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.couponList[index];
    return GestureDetector(
      onTap: () {},
      child: Container(),
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
          "关于我们",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: Adapt.px(180),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: Adapt.px(30),
                    ),
                    loadLocalImage("logo",
                        width: Adapt.px(70), height: Adapt.px(70)),
                    SizedBox(
                      height: Adapt.px(15),
                    ),
                    Text(
                      GlobalConfig.appName,
                      style: const TextStyle(
                          fontSize: TextSize.big, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'V${GlobalConfig.appVersion}',
                      style: const TextStyle(fontSize: TextSize.minor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: Adapt.px(45),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Adapt.px(15)),
                      child: const Text(
                        "版本更新",
                        style: TextStyle(fontSize: TextSize.big),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: Adapt.px(15)),
                      child: loadLocalImage("mine/mine_arrown_right",
                          width: Adapt.px(9), height: Adapt.px(16)),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":"https://wxpay.jinoufe.com/app/personal-center/agreement"});
                // Routers.push(context, WebViewRouter.webView, params: {
                //   "url":
                //       "https://wxpay.jinoufe.com/app/personal-center/agreement"
                // });
              },
              child: Container(
                width: double.infinity,
                height: Adapt.px(45),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Adapt.px(15)),
                      child: const Text(
                        "用户协议",
                        style: TextStyle(fontSize: TextSize.big),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: Adapt.px(15)),
                      child: loadLocalImage("mine/mine_arrown_right",
                          width: Adapt.px(9), height: Adapt.px(16)),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":"https://wxpay.jinoufe.com/app/personal-center/privacy"});
                // Routers.push(context, WebViewRouter.webView, params: {
                //   "url": "https://wxpay.jinoufe.com/app/personal-center/privacy"
                // });
              },
              child: Container(
                width: double.infinity,
                height: Adapt.px(45),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Adapt.px(15)),
                      child: const Text(
                        "隐私政策",
                        style: TextStyle(fontSize: TextSize.big),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: Adapt.px(15)),
                      child: loadLocalImage("mine/mine_arrown_right",
                          width: Adapt.px(9), height: Adapt.px(16)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
