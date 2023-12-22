import 'package:busenet/busenet.dart';

import '../tool.dart';

class ThreadRun implements BaseEntity<ThreadRun> {
  String? id;
  String? object;
  int? createdAt;
  String? assistantId;
  String? threadId;
  String? status;
  int? startedAt;
  int? expiresAt;
  String? cancelledAt;
  String? failedAt;
  int? completedAt;
  String? lastError;
  String? model;
  String? instructions;
  List<Tool>? tools;
  List<String>? fileIds;
  Map<String, dynamic>? metadata;

  ThreadRun(
      {this.id,
      this.object,
      this.createdAt,
      this.assistantId,
      this.threadId,
      this.status,
      this.startedAt,
      this.expiresAt,
      this.cancelledAt,
      this.failedAt,
      this.completedAt,
      this.lastError,
      this.model,
      this.instructions,
      this.tools,
      this.fileIds,
      this.metadata});

  ThreadRun.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    createdAt = json['created_at'];
    assistantId = json['assistant_id'];
    threadId = json['thread_id'];
    status = json['status'];
    startedAt = json['started_at'];
    expiresAt = json['expires_at'];
    cancelledAt = json['cancelled_at'];
    failedAt = json['failed_at'];
    completedAt = json['completed_at'];
    lastError = json['last_error'];
    model = json['model'];
    instructions = json['instructions'];
    if (json['tools'] != null) {
      tools = <Tool>[];
      json['tools'].forEach((v) {
        tools!.add(Tool.fromJson(v));
      });
    }
    fileIds = json['file_ids'].cast<String>();
    metadata = json['metadata'] != null
        ? Map<String, dynamic>.from(json['metadata'])
        : null;
  }

  @override
  ThreadRun fromJson(data) {
    return ThreadRun.fromJson(data);
  }
}
