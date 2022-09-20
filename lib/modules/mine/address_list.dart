import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'router.dart';
import 'package:hscs_flutter_app/routers.dart';

class MineAddressPage extends StatefulWidget {
  MineAddressPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineAddressPageState();
}

class _MineAddressPageState extends State<MineAddressPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getAddressList({"": ""});
    // await viewModel.getCouponDetailList({"type":widget.type,"page":1 ,"pageSize": 20});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    if(index == viewModel.addressList.length){
      return GestureDetector(
        onTap: (){
          print("新增");
          Routers.push(context, MineRouter.addressAdd);
        },
        child: Container(
          margin: EdgeInsets.only(top:Adapt.px(15),left: Adapt.px(15),right: Adapt.px(15)),
          height: Adapt.px(50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loadLocalImage("mine/address_add",width: Adapt.px(12),height: Adapt.px(12)),
              Text(" 新建地址",style: TextStyle(color: HexColor("#FB7204"),fontWeight: FontWeight.bold,fontSize: TextSize.larger),)
            ],
          ),
        ),
      );
    }
    var model = viewModel.addressList[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              offset: const Offset(0, 0.5),
              blurRadius: 8,
              spreadRadius: 0,
            )
          ],
        ),
        height: Adapt.px(130),
        margin: EdgeInsets.only(
            top: Adapt.px(15), left: Adapt.px(15), right: Adapt.px(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Adapt.px(25),
              margin: EdgeInsets.only(left: Adapt.px(15), top: Adapt.px(15)),
              child: Row(
                children: [
                  Text(
                    model.name ?? "",
                    style: const TextStyle(fontSize: TextSize.s17),
                  ),
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  Text(
                    model.mobile ?? "",
                    style: const TextStyle(
                        color: AppColors.gredText, fontSize: TextSize.main),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Adapt.px(5),
            ),
            Container(
              margin: EdgeInsets.only(left: Adapt.px(15)),
              child: Text(
                model.address ?? "",
                style: const TextStyle(
                    color: AppColors.gredText, fontSize: TextSize.main),
              ),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              height: Adapt.px(0.5),
              margin: EdgeInsets.only(left: Adapt.px(15), right: Adapt.px(15)),
              color: AppColors.line,
            ),
            SizedBox(
              height: Adapt.px(5),
            ),
            Container(
              margin: EdgeInsets.only(left: Adapt.px(15), right: Adapt.px(0)),
              width: double.infinity,
              height: Adapt.px(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Adapt.px(100),
                    child: model.isDefault! == 1
                        ? const Text(
                            "默认地址",
                            style: TextStyle(fontSize: TextSize.s17),
                          )
                        : const Text(""),
                  ),
                  SizedBox(
                    width: Adapt.px(120),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("删除");
                          },
                          child: SizedBox(
                            width: Adapt.px(60),
                            child: Center(
                              child: Text(
                                "删除",
                                style: TextStyle(
                                    color: HexColor("#E65735"),
                                    fontSize: TextSize.main1),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("修改");
                          },
                          child: SizedBox(
                            width: Adapt.px(60),
                            child: Center(
                              child: Text(
                                "修改",
                                style: TextStyle(
                                    color: HexColor("#666666"),
                                    fontSize: TextSize.main1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: HexColor("#F7F7F7"),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: loadLocalImage("page_back",
                width: Adapt.px(11), height: Adapt.px(18)),
          ),
          title: const Text(
            "我的地址",
            style: TextStyle(
                color: AppColors.text,
                fontSize: TextSize.larger,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Container(
          child: ListView.builder(
            shrinkWrap:true,
            itemBuilder: _cellForRow,
            itemCount: viewModel.addressList.length + 1,
            padding: EdgeInsets.zero,
          ),
        )
    );
  }
}
