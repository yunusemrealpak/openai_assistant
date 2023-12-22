import 'package:busenet/busenet.dart';

class Tool implements BaseEntity<Tool> {
  String? type;

  Tool({this.type});

  Tool.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }

  @override
  Tool fromJson(data) {
    return Tool.fromJson(data);
  }
}
