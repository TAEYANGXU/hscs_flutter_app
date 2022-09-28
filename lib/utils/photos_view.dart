import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);

class PhotoPreview extends StatefulWidget {
  List? galleryItems = []; //图片列表
  int? defaultImage; //默认第几张
  PageChanged? pageChanged; //切换图片回调
  Axis? direction; //图片查看方向
  BoxDecoration? decoration = BoxDecoration(color: Colors.white); //背景设计

  PhotoPreview(
      {Key? key,
      this.galleryItems,
      this.defaultImage = 1,
      this.pageChanged,
      this.direction = Axis.horizontal,
      this.decoration})
      : super(key: key);

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  int? tempSelect;

  @override
  void initState() {
    // TODO: implement initState
    tempSelect = widget.defaultImage! + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
              child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.galleryItems![index]),
                    );
                  },
                  scrollDirection: widget.direction!,
                  itemCount: widget.galleryItems!.length,
                  backgroundDecoration: widget.decoration,
                  pageController:
                      PageController(initialPage: widget.defaultImage!),
                  onPageChanged: (index) => setState(() {
                        tempSelect = index + 1;
                        if (widget.pageChanged != null) {
                          widget.pageChanged!(index);
                        }
                      }))),
          Positioned(
            ///布局自己换
            right: 20,
            top: 20,
            child: Text(
              '$tempSelect/${widget.galleryItems!.length}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.only(left: Adapt.px(15),top: Adapt.px(40)),
              // width: Adapt.px(40),
              // height: Adapt.px(40),
              // color: Colors.red,
              child: Container(
                width: Adapt.px(20),
                height: Adapt.px(30),
                child: loadLocalImage("mine/integral_white_back",
                    width: Adapt.px(14), height: Adapt.px(22)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
