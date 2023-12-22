import 'package:busenet/busenet.dart';

import 'content.dart';

class ThreadMessage implements BaseEntity<ThreadMessage> {
  String? id;
  String? object;
  int? createdAt;
  String? threadId;
  String? role;
  List<Content>? content;
  String? assistantId;
  String? runId;
  Map<String, dynamic>? metadata;

  ThreadMessage(
      {this.id,
      this.object,
      this.createdAt,
      this.threadId,
      this.role,
      this.content,
      this.assistantId,
      this.runId,
      this.metadata});

  ThreadMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    createdAt = json['created_at'];
    threadId = json['thread_id'];
    role = json['role'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
    assistantId = json['assistant_id'];
    runId = json['run_id'];
    metadata = json['metadata'] != null
        ? Map<String, dynamic>.from(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['created_at'] = createdAt;
    data['thread_id'] = threadId;
    data['role'] = role;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    data['assistant_id'] = assistantId;
    data['run_id'] = runId;
    if (metadata != null) {
      data['metadata'] = metadata;
    }
    return data;
  }

  @override
  ThreadMessage fromJson(data) {
    return ThreadMessage.fromJson(data);
  }
}
