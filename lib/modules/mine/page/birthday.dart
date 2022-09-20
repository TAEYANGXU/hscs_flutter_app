import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserBirthdayPage extends StatefulWidget {
  UserBirthdayPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserBirthdayPageState();
}

class _UserBirthdayPageState extends State<UserBirthdayPage> {

  final viewModel = MineViewModel();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future setBirthday() async {
    bool suc = await viewModel.setUserBirthday({"birthday":_controller.text});
    if(suc){
      Fluttertoast.showToast(msg: "设置成功");
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
          actions: [MaterialButton(onPressed: (){
              RegExp dateRegExp = RegExp('(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)');
              bool b= dateRegExp.hasMatch(_controller.text);
              if(!b){
                Fluttertoast.showToast(msg: "请输入正确的生日");
              }else{
                setBirthday();
              }
          },
            child: const Text("保存",style: TextStyle(fontSize: TextSize.big),),
          )],
          title: const Text(
            "填写生日",
            style: TextStyle(
                color: AppColors.text,
                fontSize: TextSize.larger,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.only(top: Adapt.px(15)),
          width: double.infinity,
          color: Colors.white,
          height: Adapt.px(50),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: Adapt.px(15)),
                height: Adapt.px(50),
                width: Adapt.px(50),
                child: const Center(child: Text("日期",style: TextStyle(fontSize: TextSize.larger),),),
              ),
              SizedBox(width: Adapt.px(10),),
              SizedBox(
                width: Adapt.screenW() - Adapt.px(80),
                height: Adapt.px(50),
                child: TextField(
                  style: const TextStyle(fontSize: TextSize.larger),
                  cursorColor: Colors.white,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "例：1997-2-16",
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
