class GankImageModel {
  //{"error":false,"results":[{"_id":"5ccdbc219d212239df927a93","createdAt":"2019-05-04T16:21:53.523Z","desc":"2019-05-05","publishedAt":"2019-05-04T16:21:59.733Z","source":"web","type":"福利","url":"http://ww1.sinaimg.cn/large/0065oQSqly1g2pquqlp0nj30n00yiq8u.jpg","used":true,"who":"lijinshanmx"}]}

  String sId;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  GankImageModel(
      {this.sId,
      this.createdAt,
      this.desc,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.used,
      this.who});

  GankImageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    desc = json['desc'];
    publishedAt = json['publishedAt'];
    source = json['source'];
    type = json['type'];
    url = json['url'];
    used = json['used'];
    who = json['who'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    data['publishedAt'] = this.publishedAt;
    data['source'] = this.source;
    data['type'] = this.type;
    data['url'] = this.url;
    data['used'] = this.used;
    data['who'] = this.who;
    return data;
  }
}
