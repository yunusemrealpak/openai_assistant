import 'package:busenet/busenet.dart';

class MessageCreation implements BaseEntity<MessageCreation> {
  String? messageId;

  MessageCreation({this.messageId});

  MessageCreation.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    return data;
  }

  @override
  MessageCreation fromJson(data) {
    return MessageCreation.fromJson(data);
  }
}
