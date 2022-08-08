
import 'dart:ui';

class BoundingBoxColors {
  List _colorList = const [Color(0xFFFF3838), Color(0xFFFF9D97), Color(0xFFFF701F),
     Color(0xFFFFB21D), Color(0xFFCFD231), Color(0xFF48F90A), Color(0xFF92CC17),
     Color(0xFF3DDB86), Color(0xFF1A9334), Color(0xFF00D4BB), Color(0xFF2C99A8),
     Color(0xFF00C2FF), Color(0xFF344593), Color(0xFF6473FF), Color(0xFF0018EC),
     Color(0xFF8438FF), Color(0xFF520085), Color(0xFFCB38FF), Color(0xFFFF95C8),
     Color(0xFFFF37C7)];

  int _index = 0;
  BoundingBoxColors() {
    _index = 0;
  }
  Color get() {
    Color color = _colorList[_index];
    // index 처리
    if (++_index == _colorList.length) {
      _index = 0;
    }
    return color;
  }
}

var lightGrey = const Color(0xffF3F3F3);
var black = const Color(0xff393939);
var red = const Color(0xffCF2525);
var redAccent = const Color(0xffFF0701);
var lime = const Color(0xff91FF00);
var grey = const Color(0xffDADADA);
var darkGrey = const Color(0xff535353);