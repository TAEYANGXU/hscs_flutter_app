import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/mine/model/address.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class MineAddressAddPage extends StatefulWidget {
  MineAddressAddPage({Key? key, this.address}) : super(key: key);
  String? address;
  @override
  State<StatefulWidget> createState() => _MineAddressAddPageState();
}

class _MineAddressAddPageState extends State<MineAddressAddPage> {
  final viewModel = MineViewModel();

  final TextEditingController nameText = TextEditingController();
  final TextEditingController mobileText = TextEditingController();
  final TextEditingController addressText = TextEditingController();
  final TextEditingController codeText = TextEditingController();
  final TextEditingController provinceText = TextEditingController();

  bool isDefault = false;
  bool saveState = false;
  Result resultArr = Result();
  AddressData? addressData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.address != null) {
      var orderDict = json.decode(widget.address!);
      addressData = AddressData.fromJson(orderDict);

      nameText.text = addressData?.name ?? "";
      mobileText.text = addressData?.mobile ?? "";
      addressText.text = addressData?.address ?? "";
      codeText.text = addressData?.postCode ?? "";
      provinceText.text = '${addressData?.province ?? ""}${addressData?.city ?? ""}${addressData?.district ?? ""}';
      setState(() {
        if( addressData?.isDefault == 1){
          isDefault = true;
        }
        saveState = true;
      });
      print('${orderDict}');
    }

    fetchData();
  }

  Future fetchData() async {
    // await viewModel.getCouponDetailList({"type":widget.type,"page":1 ,"pageSize": 20});
    setState(() {});
  }

  void saveAddress() async {
    var params = {///??????
      "name": nameText.text,
      "mobile": mobileText.text,
      "province": resultArr.provinceName,
      "city": resultArr.cityName,
      "district": resultArr.areaName,
      "address": addressText.text,
      "is_default": isDefault,
      "post_code": codeText.text
    };
    if(widget.address != null) {///??????
      params["id"] = addressData?.id;
      params["province"] = resultArr.provinceName ?? addressData?.province;
      params["city"] = resultArr.cityName ?? addressData?.city;
      params["district"] = resultArr.areaName ?? addressData?.district;
    }
    print('params = ${params}');
    bool res = await viewModel.saveAddress(params);
    if(res){
      Fluttertoast.showToast(msg: "????????????");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true);
    }
  }

  void saveButtonStyle() {
    bool edit = false;
    if (nameText.text.isNotEmpty &&
        mobileText.text.isNotEmpty &&
        provinceText.text.isNotEmpty &&
        addressText.text.isNotEmpty &&
        codeText.text.isNotEmpty) {
      edit = true;
    }
    setState(() {
      saveState = edit;
    });
  }

  void _clickEventFunc() async {
    Result? tempResult = await CityPickers.showCityPicker(
        context: context,
        // theme: Theme.of(context).copyWith(primaryColor: Color(0xfffe1314)), // ????????????
        // locationCode: resultArr != null ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId : null, // ?????????????????????
        cancelWidget: const Text(
          '??????',
          style: TextStyle(fontSize: TextSize.s17, color: AppColors.text),
        ),
        confirmWidget: const Text(
          '??????',
          style: TextStyle(fontSize: TextSize.s17, color: AppColors.theme),
        ),
        height: 220.0);
    if (tempResult != null) {
      setState(() {
        resultArr = tempResult;
        print('resultArr = $resultArr');
        provinceText.text = '${resultArr.provinceName}${resultArr.cityName}${resultArr.areaName}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(false);
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "????????????",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(
        // color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              height: Adapt.px(50),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: Adapt.px(95),
                    padding: EdgeInsets.only(left: Adapt.px(15)),
                    child: const Text(
                      "????????????",
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                  ),
                  SizedBox(
                    width: Adapt.px(200),
                    height: Adapt.px(50),
                    child: TextField(
                      style: const TextStyle(fontSize: TextSize.big),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "???????????????",
                        hintStyle: TextStyle(fontSize: TextSize.big),
                      ),
                      controller: nameText,
                      onChanged: (str) {
                        saveButtonStyle();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Adapt.px(0.5),
              color: AppColors.line,
            ),
            Container(
              height: Adapt.px(50),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: Adapt.px(95),
                    padding: EdgeInsets.only(left: Adapt.px(15)),
                    child: const Text(
                      "???????????????",
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                  ),
                  SizedBox(
                    width: Adapt.px(200),
                    height: Adapt.px(50),
                    child: TextField(
                      style: const TextStyle(fontSize: TextSize.big),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "?????????11????????????",
                        hintStyle: TextStyle(fontSize: TextSize.big),
                      ),
                      controller: mobileText,
                      onChanged: (str) {
                        saveButtonStyle();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Adapt.px(0.5),
              color: AppColors.line,
            ),
            Container(
              height: Adapt.px(50),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: Adapt.px(95),
                    padding: EdgeInsets.only(left: Adapt.px(15)),
                    child: const Text(
                      "???????????????",
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("????????????");
                      _clickEventFunc();
                    },
                    child: Container(
                      width: Adapt.px(230),
                      height: Adapt.px(50),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(fontSize: TextSize.big),
                          cursorColor: Colors.white,
                          enabled: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "????????????/???/???",
                            hintStyle: TextStyle(fontSize: TextSize.big,color: AppColors.gredText),
                          ),
                          controller: provinceText,
                          onChanged: (str) {
                            saveButtonStyle();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: Adapt.px(15)),
                    height: Adapt.px(50),
                    width: Adapt.px(30),
                    child: Center(
                      child: loadLocalImage("mine/mine_arrown_right",
                          width: Adapt.px(9), height: Adapt.px(16)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Adapt.px(0.5),
              color: AppColors.line,
            ),
            Container(
              height: Adapt.px(50),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: Adapt.px(95),
                    padding: EdgeInsets.only(left: Adapt.px(15)),
                    child: const Text(
                      "",
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                  ),
                  SizedBox(
                    width: Adapt.px(250),
                    height: Adapt.px(50),
                    child: TextField(
                      style: const TextStyle(fontSize: TextSize.big),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "?????????????????????",
                        hintStyle: TextStyle(fontSize: TextSize.big),
                      ),
                      controller: addressText,
                      onChanged: (str) {
                        saveButtonStyle();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Adapt.px(0.5),
              color: AppColors.line,
            ),
            Container(
              height: Adapt.px(50),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: Adapt.px(95),
                    padding: EdgeInsets.only(left: Adapt.px(15)),
                    child: const Text(
                      "???????????????",
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                  ),
                  SizedBox(
                    width: Adapt.px(200),
                    height: Adapt.px(50),
                    child: TextField(
                      style: const TextStyle(fontSize: TextSize.larger),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "?????????????????????",
                        hintStyle: TextStyle(fontSize: TextSize.big),
                      ),
                      controller: codeText,
                      onChanged: (str) {
                        saveButtonStyle();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Adapt.px(0.5),
              color: AppColors.line,
            ),
            Container(
              height: Adapt.px(50),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Adapt.px(95),
                    padding: EdgeInsets.only(left: Adapt.px(15)),
                    child: const Text(
                      "???????????????",
                      style: TextStyle(fontSize: TextSize.big),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: Adapt.px(15)),
                    width: Adapt.px(60),
                    height: Adapt.px(50),
                    child: CupertinoSwitch(
                      value: isDefault,
                      activeColor: HexColor("#62C663"),
                      trackColor: HexColor("#E8E8EB"),
                      onChanged: (value) {
                        setState(() {
                          isDefault = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            GestureDetector(
              onTap: () {
                print("??????");
                if (saveState) {
                  saveAddress();
                }
              },
              child: Container(
                height: Adapt.px(50),
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: Adapt.px(15), right: Adapt.px(15)),
                decoration: BoxDecoration(
                    color: saveState ? AppColors.theme : AppColors.gredText,
                    borderRadius: BorderRadius.circular(25)),
                child: const Center(
                  child: Text(
                    "??????",
                    style: TextStyle(
                        fontSize: TextSize.larger, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
