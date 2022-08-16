import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../model/home_fund.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hscs_flutter_app/extension/gradient_button.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'section.dart';

class HomeMarketView extends StatefulWidget {
  HomeMarketView({Key? key, this.fundList}) : super(key: key);
  List<FundlistData>? fundList;

  _HomeMarketViewState createState() => _HomeMarketViewState();
}

class _HomeMarketViewState extends State<HomeMarketView> {

  List<Widget> tags(List<String> tagArr) {
    List<Widget> tagList = [];
    for (var i = 0; i < tagArr.length; i++) {
      // tagArr.forEach((tag) {
      tagList.add(Container(
        child: Row(
          children: [
            loadLocalImage('fund_gou',
                width: Adapt.px(14), height: Adapt.px(12)),
            SizedBox(
              width: 5,
            ),
            Text(tagArr[i], style: TextStyle(
                color: AppColors.gredText, fontSize: TextSize.main1),)
          ],
        ),
      ));
      if (i != tagArr.length - 1) {
        tagList.add(SizedBox(
          width: 30,
        ));
      }
    }
    ;
    return tagList;
  }

  Widget textInfo(FundlistData fund) {
    var profitText = fund.profitRate.toString() + '%';
    return Container(
      // color: Colors.red,
      height: Adapt.px(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.values,
        children: [
          Text(
            fund.profitTypeDes!,
            style: TextStyle(color: AppColors.text, fontSize: TextSize.larger),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: Adapt.px(10),
          ),
          Text(
            profitText,
            style: TextStyle(color: Colors.red, fontSize: TextSize.s36),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> pieChartText(List<AssetradioData>? assetRadio) {
    List<Widget> list = [];
    for (var i = 0; i < assetRadio!.length; i++) {
      var text =
          '${assetRadio[i].assetName}${assetRadio[i].radio}%';
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Adapt.px(8),
            height: Adapt.px(8),
            decoration: BoxDecoration(
                color: HexColor(assetRadio[i].color!),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: TextSize.small, color: AppColors.text),
          )
        ],
      ));
    }
    return list;
  }

  Widget pieChart(FundlistData fund) {
    List<AssetradioData> list = [];
    for (var i = 0; i < fund.assetRadio!.length; i++) {
      var model = fund.assetRadio![i];
      model.status = i;
      // model.hexColor = HexColor(model.color!);
      double ra = model.radio!.toDouble();
      if (ra > 0) {
        list.add(model);
      }
    }

    var seriesList = [
      charts.Series(
        id: 'radio',
        domainFn: (AssetradioData radio, _) => radio.status,
        measureFn: (AssetradioData radio, _) => radio.radio,
        colorFn: (AssetradioData radio, _) =>
            charts.ColorUtil.fromDartColor(HexColor(radio.color!)),
        data: list,
        labelAccessorFn: (AssetradioData row, _) => row.assetName!,
      )
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: Adapt.px(100),
              width: Adapt.px(100),
              child: charts.PieChart(
                seriesList,
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: (10).toInt(),
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.outside,
                        insideLabelStyleSpec: charts.TextStyleSpec(
                            fontSize: 8, color: charts.Color.white),
                      )
                    ]),
              ),
            ),
          ],
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pieChartText(fund.assetRadio),
          ),
        )
      ],
    );
  }

  Widget swiperCard(int index) {
    var fund = widget.fundList![index];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('lib/assets/image/fund_bg.png'),
            fit: BoxFit.fill),),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: Adapt.px(20),
            ),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      loadLocalImage('fund_ss',
                          width: Adapt.px(16), height: Adapt.px(15)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(fund.name!, style: TextStyle(
                          fontSize: TextSize.s17, fontWeight: FontWeight.bold),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: Adapt.px(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: tags(fund.tagArr!),
            ),
          ),
          Stack(
            children: [
              Container(
                // padding: EdgeInsets.only(top: Adapt.px(0)),
                child: fund.type == 1 ? textInfo(fund) : pieChart(fund),
              ),
              Container(
                margin: EdgeInsets.only(top: Adapt.px(30),left: Adapt.px(120)),
                height: Adapt.px(40),
                width: Adapt.px(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: fund.type != 1 ? [
                    Text("资产",style: TextStyle(fontSize: TextSize.small),),
                    Text("配置",style: TextStyle(fontSize: TextSize.small)),
                  ] : [],
                ),
              )
            ],
          ),
          lookButton(),
        ],
      ),
    );
  }

  Widget marketSwiper() {
    return Container(
      // color: Colors.yellow,
      padding: EdgeInsets.only(
          top: Adapt.px(5), left: Adapt.px(5), right: Adapt.px(5)),
      height: Adapt.px(240),
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext content, int index) {
          return swiperCard(index);
        },
        itemCount: widget.fundList!.length,
        autoplay: true,
        autoplayDelay: 80000000,
        // pagination: _buildPlugin(),
        onTap: (index) {
          print(" 点击 " + index.toString());
        },
        viewportFraction: 1,
        autoplayDisableOnInteraction: true,
        loop: true,
        scale: 1,
      ),
    );
  }

  lookAction() {
    print('立即查看');
  }

  Widget lookButton() {
    return Container(
      height: Adapt.px(36),
      padding: EdgeInsets.only(left: Adapt.px(50), right: Adapt.px(50)),
      child: GradientButton(
        onPressed: lookAction,
        colors: [
          Color.fromRGBO(245, 201, 121, 1),
          Color.fromRGBO(250, 234, 177, 1)
        ],
        child: Text(
          '立即查看',
          style: TextStyle(
              color: Color.fromRGBO(153, 111, 34, 1), fontSize: TextSize.main1),
        ),
        borderRadius: BorderRadius.circular(Adapt.px(36)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // color: Colors.red,
      height: Adapt.px(225 + 35 + 15),
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeSectionView(title: "跟投精选",),
              marketSwiper(),
            ],
          ),
          Container(
            height: Adapt.px(20),
            margin: EdgeInsets.only(top: 260),
            // color: Colors.red,
            child: Center(
              child: Text(
                '信息仅供参考，不构成对任何人的推荐，用户应当自主决策。',
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: TextSize.small, color: AppColors.gredText),
              ),
            ),
          )
        ],
      ),
    );
  }
}
