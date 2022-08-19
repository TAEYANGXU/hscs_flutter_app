import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';

class WebViewPage extends StatefulWidget {

  WebViewPage({Key? key,this.url}) : super(key: key);
  String? url = "";
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  String title = "";
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar:CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text('$title'),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",width: Adapt.px(11),height: Adapt.px(18)),
        ),
      ),
      child: SafeArea(

          child: WebView(
            initialUrl: widget.url,
            //开启Js 支持
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              //拿到controller
              _controller = controller;
            },
            onPageFinished: (url) {
              //获取网页的标题来显示
              _controller?.evaluateJavascript("document.title").then((result) {
                setState(() {
                  title = result;
                });
              }
              );
              print("输出当前地址：" + url);
            },
            navigationDelegate: (NavigationRequest request) {
              //拦截 百度账号登录跳转
              if (request.url.startsWith(
                  "https://sss")) {
                // ToastUtil.show("请求被拦截");

                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          )
      ),
    );
  }
}