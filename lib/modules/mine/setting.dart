import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'service.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'router.dart';
import 'model/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hscs_flutter_app/modules/login/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hscs_flutter_app/global_config.dart';

class MineSettingPage extends StatefulWidget {
  MineSettingPage({Key? key}) : super(key: key);
  @override
  MineSettingPageState createState() => new MineSettingPageState();
}

class MineSettingPageState extends State<MineSettingPage> {

  final viewModel = MineViewModel();
  final loginOut = LoginViewModel();

  userCleanWechat() async {
    bool suc = await viewModel.userCleanWechat();
    if(suc){
      EasyLoading.showSuccess("解锁成功");
    }
  }

  doLoginOut() async {
    bool suc = await loginOut.loginOut();
    if(suc){
      var prefe = await SharedPreferences.getInstance();
      prefe.remove(GlobalConfig.kToken);
      prefe.remove(GlobalConfig.kUserInfo);
      Provider.of<UserInfo>(context, listen: false).setInfo(null);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",width: Adapt.px(11),height: Adapt.px(18)),
        ),
        title: Text("设置",style: TextStyle(color: AppColors.text,fontSize: TextSize.larger,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(
        margin: EdgeInsets.only(top: Adapt.px(10)),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: Adapt.px(45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("清理缓存",style: TextStyle(fontSize: TextSize.big,color: AppColors.text),),
                    margin: EdgeInsets.only(left: Adapt.px(15)),
                  ),
                  Container(
                    width: Adapt.px(60),
                    height: Adapt.px(45),
                    child: Center(child:
                    Text("1.0M",style: TextStyle(fontSize: TextSize.main1,color: AppColors.gredText),),),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: Adapt.px(45),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("微信",style: TextStyle(fontSize: TextSize.big,color: AppColors.text),),
                        margin: EdgeInsets.only(left: Adapt.px(15)),
                      ),
                      Container(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child:
                            Consumer<UserInfo>(builder: (context,user,child){
                              return Text( user.info != null ? user.info!.nickname! : "",style: TextStyle(fontSize: TextSize.big,color: AppColors.text),);
                            }),
                            ),
                            SizedBox(width: Adapt.px(10),),
                            Center(
                              child: GestureDetector(
                                onTap: (){
                                  print("解绑");
                                  userCleanWechat();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: Adapt.px(15)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: Adapt.px(1),color: AppColors.text),
                                  ),
                                  width: Adapt.px(40),
                                  height: Adapt.px(25),
                                  child: Center(
                                    child: Text("解绑"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: AppColors.line,
                    margin: EdgeInsets.only(left: Adapt.px(15)),
                    width: Adapt.screenW() - Adapt.px(15),
                    height: Adapt.px(0.5),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: Adapt.px(45),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("安全中心",style: TextStyle(fontSize: TextSize.big,color: AppColors.text),),
                        margin: EdgeInsets.only(left: Adapt.px(15)),
                      ),
                      Center(
                          child: Container(
                            margin: EdgeInsets.only(right: Adapt.px(15)),
                            width: Adapt.px(9),
                            height: Adapt.px(16),
                            child: loadLocalImage("mine/mine_arrown_right",
                                width: Adapt.px(9), height: Adapt.px(16)),
                          )
                      )
                    ],
                  ),
                  Container(
                    color: AppColors.line,
                    margin: EdgeInsets.only(left: Adapt.px(15)),
                    width: Adapt.screenW() - Adapt.px(15),
                    height: Adapt.px(0.5),
                  )
                ],
              ),
            ),
            SizedBox(height: Adapt.px(10),),
            GestureDetector(
              onTap: (){
                print("退出登录");
                doLoginOut();
              },
              child: Container(
                color: Colors.white,
                height: Adapt.px(45),
                child: Center(
                  child: Text("退出登录",style: TextStyle(color: AppColors.theme,fontSize: TextSize.big),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}