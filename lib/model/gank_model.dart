import 'package:flutter_gankio/net/entity_factory.dart';

class BaseEntity<T> {
  //{"error":false,"results":[{"_id":"5ccdbc219d212239df927a93","createdAt":"2019-05-04T16:21:53.523Z","desc":"2019-05-05","publishedAt":"2019-05-04T16:21:59.733Z","source":"web","type":"福利","url":"http://ww1.sinaimg.cn/large/0065oQSqly1g2pquqlp0nj30n00yiq8u.jpg","used":true,"who":"lijinshanmx"}]}

  bool error;
  List<T> results = [];
  T data;
  String errorMessage;

  BaseEntity({this.error, this.results, this.errorMessage});

  BaseEntity.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json.containsKey("results") && json["results"] != null) {
      if (json["results"] is List) {
        (json["results"] as List).forEach((item) {
          results.add(EntityFactory.generateOBJ<T>(item));
        });
      } else {
        if (T.toString() == "String") {
          //字符串
          data = json["results"].toString() as T;
        } else if (T.toString() == "Map<dynamic, dynamic>") {
          //字典
          data = json["results"] as T;
        } else {
          //
          data = EntityFactory.generateOBJ(json["results"]);
        }
      }
    }
    // results = new List<T>();
    // json['results'].forEach((v) {
    //   results.add(new T.fromJson(v));
    // });
  }
}
