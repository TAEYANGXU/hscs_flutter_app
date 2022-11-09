import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../../../extension/loading_icon.dart';


class SearchBarView extends StatefulWidget {
  SearchBarView({Key? key,this.onChanged}) : super(key: key);

  final ValueChanged<String>? onChanged;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchBarViewState();
  }
}

class _SearchBarViewState extends State<SearchBarView> {

  final TextEditingController _textEditingController = TextEditingController();
  bool _showClear = false;

  void _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _showClear = true;
      });
    } else {
      setState(() {
        _showClear = false;
      });
    }
    if(widget.onChanged != null){
      widget.onChanged!(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: Adapt.px(55)),
      width: double.infinity,
      // height: Adapt.px(50),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: Adapt.px(15)),
            height: Adapt.px(35),
            width: Adapt.screenW() - Adapt.px(80),
            decoration: BoxDecoration(
              color: HexColor("#EEEEEE"),
              borderRadius: BorderRadius.circular(Adapt.px(8)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: Adapt.px(10),
                ),
                loadLocalImage("live/search_icon",
                    width: Adapt.px(16), height: Adapt.px(16)),
                SizedBox(
                  width: Adapt.px(5),
                ),
                Expanded(
                  child: TextField(
                    onChanged: _onChanged,
                    cursorColor: Colors.green,
                    autofocus: true,
                    controller: _textEditingController,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.only(left: 5, bottom: 10),
                        border: InputBorder.none,
                        hintText: '搜索内容',
                        hintStyle: TextStyle(
                            fontSize: TextSize.big,
                            color: AppColors.gredText)),
                  ),
                ),
                if (_showClear)
                  GestureDetector(
                    onTap: () {
                      _textEditingController.clear();
                      setState(() {
                        _onChanged("");
                      });
                    },
                    child: SizedBox(
                      width: Adapt.px(30),
                      height: Adapt.px(35),
                      child: Center(
                        child: loadLocalImage("live/search_close",
                            width: Adapt.px(16), height: Adapt.px(16)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: Adapt.px(10),
          ),
          GestureDetector(
            onTap: (){
              print("object");
              Navigator.of(context).pop();
            },
            child: Container(
              height: Adapt.px(40),
              width: Adapt.px(50),
              color: Colors.white,
              child: const Center(
                child: Text(
                  "取消",
                  style: TextStyle(
                      fontSize: TextSize.larger,
                      color: AppColors.gredText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
