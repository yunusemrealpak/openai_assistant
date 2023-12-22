import 'package:busenet/busenet.dart';

import 'content_text.dart';

class Content implements BaseEntity<Content> {
  String? type;
  ContentText? text;

  Content({this.type, this.text});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'] != null ? ContentText.fromJson(json['text']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (text != null) {
      data['text'] = text!.toJson();
    }
    return data;
  }

  @override
  Content fromJson(data) {
    return Content.fromJson(data);
  }
}
