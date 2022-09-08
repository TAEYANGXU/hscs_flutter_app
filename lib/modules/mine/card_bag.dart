import 'package:flutter/material.dart';
import '../../style/index.dart';
import '../../utils/index.dart';

class MineCardBagPage extends StatefulWidget
{
  MineCardBagPage({Key? key}) : super(key:key);
  @override
  State<StatefulWidget> createState() => _MineCardBagPageState();
}

class  _MineCardBagPageState extends State<MineCardBagPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "卡券包",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(),
    );
  }
}