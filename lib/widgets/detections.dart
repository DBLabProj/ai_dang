import 'package:ai_dang/widgets/colors.dart';

class Detections {
  BoundingBoxColors boundColors = BoundingBoxColors();
  List rects = [];

  Detections(detectInfo, ratio) {
    int index = 1;

    for (var detection in detectInfo) {
      Map rect = {};
      rect['index'] = index ++;
      rect['name'] = detection['name'].toString();
      rect['x'] = detection['xmin'].toDouble() * ratio;
      rect['y'] = detection['ymin'].toDouble() * ratio;
      rect['w'] = (detection['xmax'].toDouble() * ratio) - rect['x'];
      rect['h'] = (detection['ymax'].toDouble() * ratio) - rect['y'];

      rect['color'] = boundColors.get();
      rects.add(rect);
    }
  }

  List getRectInfo() {
    return rects;
  }
}