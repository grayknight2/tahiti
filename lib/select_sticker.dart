import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tahiti/activity_model.dart';
import 'package:tahiti/camera.dart';
import 'package:tahiti/display_sticker.dart';
import 'package:tahiti/popup_grid_view.dart';
import 'package:tahiti/recorder.dart';
import 'package:tahiti/color_picker.dart';

final Map<String, List<Iconf>> bottomStickers = {
  'assets/menu/text.png': [
    Iconf(type: ItemType.text, data: 'Bungee'),
    Iconf(type: ItemType.text, data: 'Chela one'),
    Iconf(type: ItemType.text, data: 'Gloria Hallelujah'),
    Iconf(type: ItemType.text, data: 'Great vibes'),
    Iconf(type: ItemType.text, data: 'Homemade apple'),
    Iconf(type: ItemType.text, data: 'Indie Flower'),
    Iconf(type: ItemType.text, data: 'Kirang Haerang'),
    Iconf(type: ItemType.text, data: 'Pacifico'),
    Iconf(type: ItemType.text, data: 'Patrick Hand'),
    Iconf(type: ItemType.text, data: 'Roboto'),
    Iconf(type: ItemType.text, data: 'Rock salt'),
    Iconf(type: ItemType.text, data: 'Shadows into light'),
  ],
  'assets/menu/happy.png': [
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/angry.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/cold.gif'),
    Iconf(
      type: ItemType.png,
      data: 'assets/stickers/emoguy/cry.gif',
    ),
    Iconf(
      type: ItemType.png,
      data: 'assets/stickers/emoguy/happy.gif',
    ),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/laughing.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/love.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/playing.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/relaxed.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/sad.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/scared.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/sleeping.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/thumbsdown.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/thumbup.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/workingout.gif'),
    Iconf(type: ItemType.png, data: 'assets/stickers/emoguy/yummy.gif'),
  ],
  'assets/menu/icon.png': [
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/pen'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/ball'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/men'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/monkey'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/pot'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/carrot'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bat'),
  ],
  'assets/menu/body_icon.png': [
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/back'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/beard'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/chest'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/ear'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/eyes'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/forehead'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/hair'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/leg'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/lips'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/mouth'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/mustache'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/palm'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/bodyparts/toe'),
  ],
  'assets/menu/food_icon.png': [
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/almond'),
    Iconf(
        type: ItemType.sticker, data: 'assets/svgimage/fooditem/bar_icecream'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/beer_jug'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/bread'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/burger'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/cake'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/candy'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/cashewnut'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/champaign'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/cheese'),
    Iconf(
        type: ItemType.sticker,
        data: 'assets/svgimage/fooditem/chicken_drumstick'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/chips'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/chocolate'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/cocktail'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/cocoa_bean'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/coffee'),
    Iconf(
        type: ItemType.sticker, data: 'assets/svgimage/fooditem/cone_icecream'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/cookie'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/dates'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/donut'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/dry_coconut'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/dumpling'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/egg'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/hazel_nut'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/honey'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/hotdog'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/juice'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/lollypop'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/meat_can1'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/meat'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/milk'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/mocktail'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/noodles'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/omlet'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/peanuts'),
    Iconf(
        type: ItemType.sticker, data: 'assets/svgimage/fooditem/piece_of_cake'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/pizza'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/popcorn'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/raisin'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/salad'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/sandwich'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/scrat_nut'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/soup'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/sushi'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/tea'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/toffee'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/veg_roll'),
    Iconf(type: ItemType.sticker, data: 'assets/svgimage/fooditem/vine'),
  ],
  'assets/menu/giraffe.png': [
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/1.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/10.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/11.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/12.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/13.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/14.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/15.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/16.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/2.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/3.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/4.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/5.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/6.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/7.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/8.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/giraffe/9.png'),
  ],
  'assets/menu/pig.png': [
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/1.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/10.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/11.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/12.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/13.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/14.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/15.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/16.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/2.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/3.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/4.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/5.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/6.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/7.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/8.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/pig/9.png'),
  ],
  'assets/menu/monkey.png': [
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/1.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/10.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/11.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/12.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/13.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/14.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/15.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/16.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/2.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/3.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/4.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/5.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/6.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/7.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/8.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/monkey/9.png'),
  ],
  'assets/menu/carpie.png': [
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/1.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/10.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/11.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/12.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/13.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/14.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/15.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/16.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/2.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/3.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/4.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/5.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/6.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/7.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/8.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/carpie/9.png'),
  ],
  'assets/menu/doggie.png': [
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/1.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/10.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/11.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/12.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/13.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/14.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/15.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/16.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/2.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/3.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/4.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/5.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/6.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/7.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/8.png'),
    Iconf(type: ItemType.png, data: 'assets/stickers/doggie/9.png'),
  ],
};

class TopStickers {
  static List<Iconf> nimalist = [
    Iconf(type: ItemType.png, data: 'assets/nima_animation/Hop.png'),
  ];

  static String stopIcon = 'assets/mic/stop.png';
  static List<Iconf> playIcon = [
    Iconf(type: ItemType.png, data: 'assets/mic/play.png')
  ];
  final Map<String, List<Iconf>> topStickers = {
    'assets/menu/mic.png': playIcon,
    'assets/menu/camera.png': [
      Iconf(type: ItemType.png, data: 'assets/camera/camera1.png'),
      Iconf(type: ItemType.png, data: 'assets/camera/gallery.png'),
      Iconf(type: ItemType.png, data: 'assets/camera/video.png'),
    ],
    'assets/menu/pencil.png': [
      Iconf(type: ItemType.png, data: 'assets/drawing/size1.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size2.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size3.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size4.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size5.png'),
    ],
    'assets/menu/eraser.png': [
      Iconf(type: ItemType.png, data: 'assets/drawing/size1.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size2.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size3.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size4.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size5.png'),
    ],
    'assets/menu/brush.png': [
      Iconf(type: ItemType.png, data: 'assets/drawing/size1.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size2.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size3.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size4.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size5.png'),
    ],
    'assets/menu/brush1.png': [
      Iconf(type: ItemType.png, data: 'assets/drawing/size1.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size2.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size3.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size4.png'),
      Iconf(type: ItemType.png, data: 'assets/drawing/size5.png'),
    ],
    'assets/menu/bucket.png': [],
    'assets/menu/roller.png': [
      Iconf(type: ItemType.png, data: 'assets/roller_image/sample1.jpg'),
      Iconf(type: ItemType.png, data: 'assets/roller_image/sample2.jpg'),
      Iconf(type: ItemType.png, data: 'assets/roller_image/sample3.jpg'),
      Iconf(type: ItemType.png, data: 'assets/roller_image/sample4.jpg'),
      Iconf(type: ItemType.png, data: 'assets/roller_image/sample5.jpg'),
    ],
    'assets/filter_icon.jpg': [],
  };
}

class SelectSticker extends StatefulWidget {
  static Recorder recorder = new Recorder();
  final OnUserPress onUserPress;
  final DisplaySide side;
  SelectSticker({this.side, this.onUserPress});

  @override
  SelectStickerState createState() {
    return new SelectStickerState();
  }
}

class SelectStickerState extends State<SelectSticker> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActivityModel>(
        builder: (context, child, model) => PopupGridView(
              side: widget.side,
              onUserPress: (text) {
                print(text);
                switch (text) {
                  case 'assets/drawing/size1.png':
                    model.painterController.thickness = 1.2;
                    break;
                  case 'assets/drawing/size2.png':
                    model.painterController.thickness = 5.0;
                    break;
                  case 'assets/drawing/size3.png':
                    model.painterController.thickness = 8.0;
                    break;
                  case 'assets/drawing/size4.png':
                    model.painterController.thickness = 10.0;
                    break;
                  case 'assets/drawing/size5.png':
                    model.painterController.thickness = 15.0;
                    break;
                  case 'assets/mic/stop.png':
                    SelectSticker.recorder.stop();
                    setState(() {
                      TopStickers.playIcon = TopStickers.nimalist;
                    });

                    break;
                  case 'assets/mic/play.png':
                    SelectSticker.recorder.start();
                    if (SelectSticker.recorder.isRecorded) {
                      SelectSticker.recorder.start();
                    } else {
                      setState(() {
                        TopStickers.playIcon = [
                          Iconf(type: ItemType.png, data: TopStickers.stopIcon)
                        ];
                      });
                    }
                    break;
                  case 'assets/camera/camera1.png':
                    new Camera().openCamera().then((p) {
                      if (p != null) model.addImage(p);
                    });
                    break;
                  case 'assets/camera/gallery.png':
                    new Camera().pickImage().then((p) {
                      if (p != null) model.addImage(p);
                    });
                    break;
                  case 'assets/camera/video.png':
                    new Camera().videoRecorder().then((p) {
                      if (p != null) model.addVideo(p.path);
                    });
                    break;
                  default:
                    if (text.startsWith('assets/stickers') ||
                        text.startsWith('assets/svgimage')) {
                      model.addSticker(text);
                    }
                    if (text.startsWith('assets/nima_animation')) {
                      model.addNima(text);
                    }
                    if (text.startsWith('assets/roller_image')) {
                      model.addUnMaskImage(text);
                      model.painterController.doUnMask();
                      model.isDrawing = true;
                    }
                }
              },
              menuItems: widget.side == DisplaySide.bottom
                  ? bottomStickers
                  : TopStickers().topStickers,
              numFixedItems: widget.side == DisplaySide.bottom ? 1 : 0,
              itemCrossAxisCount: 2,
              buildItem: buildItem,
              buildIndexItem: buildIndexItem,
            ));
  }

  Widget buildItem(BuildContext context, Iconf conf, bool enabled) {
    if (conf.type == ItemType.text)
      return Container(
        child: Center(
            child: new Text(
          "abc",
          style: TextStyle(fontFamily: conf.data, fontSize: 30.0),
        )),
        color: Colors.blueAccent[100],
      );
    else if (conf.type == ItemType.sticker) {
      return DisplaySticker(
        primary: conf.data,
        color: ActivityModel.of(context).selectedColor,
      );
    } else
      return Image.asset(
        conf.data,
        package: 'tahiti',
      );
  }

  Widget buildIndexItem(BuildContext context, Iconf conf, bool enabled) {
    return Image.asset(
      conf.data,
      package: 'tahiti',
    );
  }
}
