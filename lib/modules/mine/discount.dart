import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';

class MineDiscountPage extends StatefulWidget {
  MineDiscountPage({Key? key,this.type}) : super(key: key);
  int? type;
  @override
  State<StatefulWidget> createState() => _MineDiscountPageState();
}

class _MineDiscountPageState extends State<MineDiscountPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getCouponDetailList({"type":widget.type,"page":1 ,"pageSize": 20});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.couponList[index];
    return GestureDetector(
      onTap: (){

      },
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
          "优惠券",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SizedBox(
        child: ListView.builder(
          itemBuilder: _cellForRow,
          itemCount: viewModel.couponList.length,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}