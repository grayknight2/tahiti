import 'package:tahiti/popup_grid_view.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tahiti/drawing.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Model {
  List<Map<String, dynamic>> things = [];
  List<Map<String, dynamic>> _undoStack = [];
  List<Map<String, dynamic>> _redoStack = [];
  String _template;
  Function _saveCallback;
  Popped _popped = Popped.noPopup;
  String _highlighted;
  bool _isDrawing = false;
  PainterController _painterController;
  PathHistory pathHistory;

  @JsonKey(fromJson: _colorFromInt, toJson: _intFromColor)
  Color _textColor;
  Color _stickerColor;
  Color _drawingColor;
  Color _selectedColor;

  String id;
  bool _isInteractive = true;
  String selectedIcon;

  Color color = Colors.white;
  BlendMode blendMode = BlendMode.dst;
  String _selectedThingId;
  bool _editSelectedThing=false;
  Color cls;
  BlendMode blnd;

  ActivityModel({@required this.pathHistory, @required this.id}) {
    print('pathHistory: $pathHistory');
    _painterController = new PainterController(pathHistory: this.pathHistory);
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  static ActivityModel of(BuildContext context) =>
      ScopedModel.of<ActivityModel>(context);

  PainterController get painterController => this._painterController;

  set saveCallback(Function s) => _saveCallback = s;

  String get template => _template;
  set template(String t) {
    _template = t;
    _saveAndNotifyListeners();
  }

  // TODO:// onTap and pass id of selected thing here
  String get selectedThingId => _selectedThingId;
  set selectedThingId(String id) {
    _selectedThingId = id;
    notifyListeners();
  }

  bool get editSelectedThing => _editSelectedThing;
  set editSelectedThing(bool state){
    _editSelectedThing = state;
    notifyListeners();
  }


  set selecetedStickerIcon(String t) {
    selectedIcon = t;
    notifyListeners();
  }

  Color get textColor => _textColor;
  set textColor(Color t) {
    _textColor = t;
    notifyListeners();
  }

  Color get selectedColor => _selectedColor;
  set selectedColor(Color t) {
    _selectedColor = t;
    notifyListeners();
  }

  Color get stickerColor => _stickerColor;
  set stickerColor(Color t) {
    _stickerColor = t;
    notifyListeners();
  }

  Color get drawingColor => _drawingColor;
  set drawingColor(Color t) {
    _drawingColor = t;
    notifyListeners();
  }

  Popped get popped => _popped;
  set popped(Popped t) {
    _popped = t;
    notifyListeners();
  }

  String get highlighted => _highlighted;
  set highlighted(String t) {
    _highlighted = t;
    notifyListeners();
  }

  bool get isDrawing => _isDrawing;
  set isDrawing(bool t) {
    _isDrawing = t;
    notifyListeners();
  }

  bool get isInteractive => _isInteractive;
  set isInteractive(bool i) => _isInteractive = i;

  void addSticker(String name) {
    addThing({
      'id': Uuid().v4(),
      'type': 'sticker',
      'asset': name,
      'x': 0.0,
      'y': 0.0,
      'scale': 0.5,
      'color': stickerColor?.value ?? Colors.red.value
    });
  }

  void addImage(String imagePath) {
    addThing({
      'id': Uuid().v4(),
      'type': 'image',
      'path': imagePath,
      'x': 0.0,
      'y': 0.0,
      'scale': 0.5,
      'color': color,
      'blendMode': blendMode,
    });
  }

  void addVideo(String videoPath) {
    addThing({
      'id': Uuid().v4(),
      'type': 'video',
      'path': videoPath,
      'x': 0.0,
      'y': 0.0,
      'scale': 0.5
    });
  }

  void addText(String text, {String font}) {
    bool temp = false;
    things.forEach((t) {
      if (t['text'] == '') {
        temp = true;
        _selectedThingId = t['id'];
        t['font'] = font;
      }
      notifyListeners();
    });
    if (!temp) {
      addThing({
        'id': Uuid().v4(),
        'type': 'text',
        'text': text,
        'font': font,
        'color': textColor?.value ?? Colors.white.value,
        'x': 0.0,
        'y': 0.0,
        'scale': 1.0
      });
    }
  }

  void addNima(String name) {
    addThing({
      'id': Uuid().v4(),
      'type': 'nima',
      'asset': name,
      'x': 0.0,
      'y': 0.0,
      'scale': 0.5,
    });
  }

  void selectedThing(var id, String type, String text) {
    things.forEach((t) {
      if (t['id'] == id) {
        if (type == 'text' || type == 'image' || type == 'sticker') {
          if (type == 'text') {
            t['text'] = text;
          }
        }
      } else {
        t['select'] = false;
      }
      if (t['id'] == _selectedThingId && t['type'] == 'image') {
        t.forEach((k, v) {
          if (k == 'color' || k == 'blendMode') {
            t['color'] = cls;
            t['blendMode'] = blnd;
          }
        });
      }
    });
    notifyListeners();
  }

  void deletedThing(var id) {
    things.removeWhere((t) => t['id'] == id);
    notifyListeners();
  }

  void addDrawing(PathInfo path) {
    addThing({'id': Uuid().v4(), 'type': 'drawing', 'path': path});
    debugPrint(json.encode(this));
  }

  void addThing(Map<String, dynamic> thing) {
    selectedThingId = thing['id'];
    _addThing(thing);
    _redoStack.clear();
  }

  void _addThing(Map<String, dynamic> thing) {
    print('_addThing: $thing');
    thing['op'] = 'add';
    things.add(thing);
    _undoStack.add(Map.from(thing));
    print('_addThing: $_undoStack $_redoStack');
    _saveAndNotifyListeners();
  }

  void updateThing(Map<String, dynamic> thing) {
    _updateThing(thing);
    _redoStack.clear();
  }

  void _updateThing(Map<String, dynamic> thing) {
    print('updateThing: $thing');
    final index = things.indexWhere((t) => t['id'] == thing['id']);
    if (index >= 0) {
      things[index]['op'] = 'update';
      _undoStack.add(things[index]);
      thing['op'] = 'update';
      things[index] = thing;
    }
    print('updateThing: $_undoStack $_redoStack');
    _saveAndNotifyListeners();
  }

  bool canUndo() {
    return _undoStack.isNotEmpty;
  }

  void undo() {
    print('undo: $_undoStack $_redoStack');
    final thing = _undoStack.removeLast();
    if (thing['op'] == 'add') {
      things.removeWhere((t) => t['id'] == thing['id']);
      _redoStack.add(thing);
      if (thing['type'] == 'drawing') {
        painterController.undo();
      }
    } else {
      //assume it is update
      final index = things.indexWhere((t) => t['id'] == thing['id']);
      _redoStack.add(things[index]);
      things[index] = thing;
    }
    print('undo: $_undoStack $_redoStack');
    _saveAndNotifyListeners();
  }

  bool canRedo() {
    return _redoStack.isNotEmpty;
  }

  void redo() {
    print('redo: $_undoStack $_redoStack');
    final thing = _redoStack.removeLast();
    if (thing['op'] == 'add') {
      _addThing(thing);
      if (thing['type'] == 'drawing') {
        painterController.redo(thing['path']);
      }
    } else {
      //assume it is update
      _updateThing(thing);
    }
    print('redo: $_undoStack $_redoStack');
  }

  void _saveAndNotifyListeners() {
    if (_saveCallback != null) _saveCallback(jsonMap: toJson());
    notifyListeners();
  }

  String unMaskImagePath;
  void addUnMaskImage(String text) {
    print("text: $text");
    unMaskImagePath = text;
    notifyListeners();
  }
}

Color _colorFromInt(int colorValue) => Color(colorValue);
int _intFromColor(Color color) => color.value;

BlurStyle _blurStyleFromInt(int blurStyleValue) =>
    BlurStyle.values[blurStyleValue];
int _intFromBlurStyle(BlurStyle blurStyle) => blurStyle.index;

@JsonSerializable()
class PathHistory {
  List<PathInfo> paths;

  PathHistory() {
    paths = [];
  }

  factory PathHistory.fromJson(Map<String, dynamic> json) =>
      _$PathHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$PathHistoryToJson(this);

  void undo() {
    paths.removeLast();
  }

  void redo(PathInfo pathInfo) {
    paths.add(pathInfo);
  }

  void clear() {
    paths.clear();
  }

  void add(Offset startPoint,
      {PaintOption paintOption,
      BlurStyle blurStyle,
      double sigma,
      double thickness,
      Color color}) {
    paths.add(PathInfo(
        points: [startPoint.dx, startPoint.dy],
        paintOption: paintOption,
        blurStyle: blurStyle,
        sigma: sigma,
        thickness: thickness,
        color: color));
  }

  void updateCurrent(Offset nextPoint) {
    paths.last.addPoint(nextPoint);
  }

  void draw(PaintingContext context, Size size) {
    for (PathInfo pathInfo in paths) {
      context.canvas.drawPath(pathInfo.path, pathInfo._paint);
    }
  }
}

@JsonSerializable()
class PathInfo {
  Paint _paint;

  Path _path;

  get path => _path;

  List<double> points;
  PaintOption paintOption;
  @JsonKey(fromJson: _blurStyleFromInt, toJson: _intFromBlurStyle)
  BlurStyle blurStyle;
  double sigma;
  double thickness;
  @JsonKey(fromJson: _colorFromInt, toJson: _intFromColor)
  Color color;

  PathInfo(
      {this.points,
      this.paintOption = PaintOption.paint,
      this.blurStyle = BlurStyle.normal,
      this.sigma = 0.0,
      this.thickness = 8.0,
      this.color = Colors.red}) {
    _path = new Path();
    if (points.length >= 2) {
      _path.moveTo(points[0], points[1]);
    }
    for (int i = 2; i < points.length - 1; i += 2) {
      _path.lineTo(points[i], points[i + 1]);
    }

    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = thickness
      ..color = color ?? Colors.red;
    switch (paintOption) {
      case PaintOption.paint:
        _paint.maskFilter = MaskFilter.blur(blurStyle, sigma);
        break;
      case PaintOption.unMask:
        _paint.blendMode = BlendMode.clear;
        break;
      case PaintOption.erase:
        _paint.blendMode = BlendMode.clear;
        break;
    }
  }

  factory PathInfo.fromJson(Map<String, dynamic> json) =>
      _$PathInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PathInfoToJson(this);

  addPoint(Offset nextPoint) {
    _path.lineTo(nextPoint.dx, nextPoint.dy);
    points.addAll([nextPoint.dx, nextPoint.dy]);
  }
}

//TODO: maskFilter
//Paint _paintFromMap(Map<String, dynamic> map) => Paint()
//  ..style = PaintingStyle.stroke
//  ..strokeCap = StrokeCap.round
//  ..strokeJoin = StrokeJoin.round
//  ..strokeWidth = (map['strokeWidth'] as double)
//  ..color = Color(map['color'] as int);
//
//Map<String, dynamic> _paintToMap(Paint paint) => {
//      'strokeWidth': paint.strokeWidth,
//      'color': paint.color.value,
//    };
