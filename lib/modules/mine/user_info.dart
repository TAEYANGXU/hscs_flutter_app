import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'model/user.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {}

  updateUser(String avatar) async {
    bool suc = await viewModel.updateUser({"avatar": avatar});
    if (suc) {
      Fluttertoast.showToast(msg: "上传成功");
    }
  }

  showPicker() {
    //底部弹出
    showModalBottomSheet(
        context: context,
        builder: (BuildContext con) => Container(
              height: Adapt.px(160),
              padding: EdgeInsets.all(Adapt.px(20)),
              color: Colors.white,
              child: SizedBox(
                child: ListView(
                  children: [createItem(true, "拍照"), createItem(false, "相册")],
                ),
              ),
            ));
  }

  Widget createItem(bool state, String name) {
    return GestureDetector(
        onTap: () {
          //点击事件处理
          openPicker(state);
        },
        child: ListTile(
          leading: Icon(state ? Icons.camera : Icons.image),
          title: Text(name),
        )
    );
  }

  //使用imagePicker异步打开拍照 、相册
  openPicker(bool state) async {
    //销毁底部弹出框
    Navigator.pop(context);
    var picker = ImagePicker();
    //根据状态标识决定打开相机还是相册
    XFile? pickedFile = await picker.pickImage(
        source: state ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      //上传
      File imageFile = File(pickedFile!.path);
      String base64Image = base64Encode(imageFile.readAsBytesSync());
      updateUser(base64Image);
    });
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
          "修改个人信息",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(
        color: Colors.white,
        child: Consumer<UserInfo>(
          builder: (context, user, build) {
            return Column(
              children: [
                SizedBox(
                  height: Adapt.px(45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: Adapt.px(15)),
                        child: const Text(
                          "头像",
                          style: TextStyle(fontSize: TextSize.big),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPicker();
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: Adapt.px(10)),
                          child: Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: CacheImage(
                                  imageUrl: user.info?.avatar,
                                  width: Adapt.px(30),
                                  height: Adapt.px(30),
                                ),
                              ),
                              SizedBox(
                                width: Adapt.px(6),
                              ),
                              loadLocalImage("mine/mine_arrown_right",
                                  width: Adapt.px(9), height: Adapt.px(16))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: AppColors.line,
                  width: double.infinity,
                  height: Adapt.px(1),
                ),
                GestureDetector(
                  onTap: () {
                    Routers.push(context, MineRouter.nickname);
                  },
                  child: Container(
                    color: Colors.white,
                    height: Adapt.px(45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: Adapt.px(15)),
                          child: const Text(
                            "昵称",
                            style: TextStyle(fontSize: TextSize.big),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: Adapt.px(10)),
                          child: Row(
                            children: [
                              (user.info!.verifyNickname!.isNotEmpty)
                                  ? loadLocalImage("mine/mine_audit_icon",
                                      width: Adapt.px(14), height: Adapt.px(16))
                                  : Container(),
                              SizedBox(
                                width: Adapt.px(3),
                              ),
                              SizedBox(
                                  child: Text(
                                      (user.info!.verifyNickname!.isNotEmpty)
                                          ? user.info!.verifyNickname!
                                          : user.info!.nickname!)),
                              SizedBox(
                                width: Adapt.px(6),
                              ),
                              loadLocalImage("mine/mine_arrown_right",
                                  width: Adapt.px(9), height: Adapt.px(16))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: AppColors.line,
                  width: double.infinity,
                  height: Adapt.px(1),
                ),
                GestureDetector(
                  onTap: () {
                    if (user.info!.birthday!.isEmpty) {
                      Routers.push(context, MineRouter.birthday);
                    }
                  },
                  child: SizedBox(
                    height: Adapt.px(45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: Adapt.px(15)),
                          child: const Text(
                            "生日",
                            style: TextStyle(fontSize: TextSize.big),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: Adapt.px(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                  child: Text((user.info!.birthday!.isNotEmpty)
                                      ? user.info!.birthday!
                                      : "你还未填写生日哦~")),
                              SizedBox(
                                width: Adapt.px(6),
                              ),
                              (user.info!.birthday!.isNotEmpty)
                                  ? Container()
                                  : loadLocalImage("mine/mine_arrown_right",
                                      width: Adapt.px(9), height: Adapt.px(16))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: AppColors.line,
                  width: double.infinity,
                  height: Adapt.px(1),
                ),
                GestureDetector(
                  onTap: (){
                    Routers.push(context, MineRouter.addressList);
                  },
                  child: Container(
                    color: Colors.white,
                    height: Adapt.px(45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: Adapt.px(15)),
                          child: const Text(
                            "我的地址",
                            style: TextStyle(fontSize: TextSize.big),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: Adapt.px(10)),
                          child: Row(
                            children: [
                              loadLocalImage("mine/mine_arrown_right",
                                  width: Adapt.px(9), height: Adapt.px(16))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: AppColors.line,
                  width: double.infinity,
                  height: Adapt.px(1),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
