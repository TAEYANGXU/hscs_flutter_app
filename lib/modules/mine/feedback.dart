import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';

class MineFeedbackPage extends StatefulWidget {
  MineFeedbackPage({Key? key,this.type}) : super(key: key);
  int? type;
  @override
  State<StatefulWidget> createState() => _MineFeedbackPageState();
}

class _MineFeedbackPageState extends State<MineFeedbackPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          "意见反馈",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(

      ),
    );
  }
}