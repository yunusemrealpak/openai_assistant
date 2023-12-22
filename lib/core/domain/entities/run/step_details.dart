import 'package:busenet/busenet.dart';

import 'message_creation.dart';

class StepDetails implements BaseEntity<StepDetails> {
  String? type;
  MessageCreation? messageCreation;

  StepDetails({this.type, this.messageCreation});

  StepDetails.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    messageCreation = json['message_creation'] != null
        ? MessageCreation.fromJson(json['message_creation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (messageCreation != null) {
      data['message_creation'] = messageCreation!.toJson();
    }
    return data;
  }

  @override
  StepDetails fromJson(data) {
    return StepDetails.fromJson(data);
  }
}
