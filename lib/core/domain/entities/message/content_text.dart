import 'package:busenet/busenet.dart';

class ContentText implements BaseEntity<ContentText> {
  String? value;

  ContentText({this.value});

  ContentText.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }

  @override
  ContentText fromJson(data) {
    return ContentText.fromJson(data);
  }
}
