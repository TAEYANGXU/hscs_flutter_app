import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'dart:convert' as Convert;

class UserNikenamePage extends StatefulWidget {
  UserNikenamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserNikenamePageState();
}

class _UserNikenamePageState extends State<UserNikenamePage> {
  final viewModel = MineViewModel();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var prefs = await SharedPreferences.getInstance();
    var userInfoMap =
        Convert.jsonDecode(prefs.get(GlobalConfig.kUserInfo).toString());
    _controller.text = userInfoMap["nickname"];
  }

  Future setNickname() async {
    bool suc = await viewModel.updateUser({"nickname": _controller.text});
    if (suc) {
      Fluttertoast.showToast(msg: "修改成功");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColors.space,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: loadLocalImage("page_back",
                width: Adapt.px(11), height: Adapt.px(18)),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                if (_controller.text.isEmpty) {
                  Fluttertoast.showToast(msg: "请输入昵称");
                } else {
                  setNickname();
                }
              },
              child: const Text(
                "保存",
                style: TextStyle(fontSize: TextSize.big),
              ),
            )
          ],
          title: const Text(
            "修改昵称",
            style: TextStyle(
                color: AppColors.text,
                fontSize: TextSize.larger,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: Adapt.px(15)),
              width: double.infinity,
              color: Colors.white,
              height: Adapt.px(50),
              child: Consumer(
                builder: (context, child, user) {
                  return Row(
                    children: [
                      SizedBox(
                        width: Adapt.px(10),
                      ),
                      SizedBox(
                        width: Adapt.screenW() - Adapt.px(80),
                        height: Adapt.px(50),
                        child: TextField(
                          style: const TextStyle(fontSize: TextSize.larger),
                          cursorColor: Colors.white,
                          controller: _controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "请输入昵称",
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: Adapt.px(5),),
            Container(
              padding: EdgeInsets.only(left: Adapt.px(15)),
              child: const Text("2-10个字符，可由中英文、数字组成",style: TextStyle(fontSize: TextSize.small,color: AppColors.gredText),),
            ),
          ],
        )
    );
  }
}
