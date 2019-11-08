import 'package:flutter_gankio/model/gank_image_model.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "String") {
      return json;
    } else if (T.toString() == "GankImageModel") {
      return GankImageModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}


