import 'package:busenet/busenet.dart';

class Thread implements BaseEntity<Thread> {
  String? id;
  String? object;
  int? createdAt;
  Map<String, dynamic>? metadata;

  Thread({this.id, this.object, this.createdAt, this.metadata});

  Thread.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    createdAt = json['created_at'];
    metadata = json['metadata'] != null
        ? Map<String, dynamic>.from(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['created_at'] = createdAt;
    if (metadata != null) {
      data['metadata'] = metadata;
    }
    return data;
  }

  @override
  Thread fromJson(data) {
    return Thread.fromJson(data);
  }
}
