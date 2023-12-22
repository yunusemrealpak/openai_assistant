import 'package:busenet/busenet.dart';

import 'step_details.dart';

class RunStep implements BaseEntity<RunStep> {
  String? id;
  String? object;
  int? createdAt;
  String? runId;
  String? assistantId;
  String? threadId;
  String? type;
  String? status;
  String? cancelledAt;
  int? completedAt;
  String? expiredAt;
  String? failedAt;
  String? lastError;
  StepDetails? stepDetails;

  RunStep(
      {this.id,
      this.object,
      this.createdAt,
      this.runId,
      this.assistantId,
      this.threadId,
      this.type,
      this.status,
      this.cancelledAt,
      this.completedAt,
      this.expiredAt,
      this.failedAt,
      this.lastError,
      this.stepDetails});

  RunStep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    createdAt = json['created_at'];
    runId = json['run_id'];
    assistantId = json['assistant_id'];
    threadId = json['thread_id'];
    type = json['type'];
    status = json['status'];
    cancelledAt = json['cancelled_at'];
    completedAt = json['completed_at'];
    expiredAt = json['expired_at'];
    failedAt = json['failed_at'];
    lastError = json['last_error'];
    stepDetails = json['step_details'] != null
        ? StepDetails.fromJson(json['step_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['created_at'] = createdAt;
    data['run_id'] = runId;
    data['assistant_id'] = assistantId;
    data['thread_id'] = threadId;
    data['type'] = type;
    data['status'] = status;
    data['cancelled_at'] = cancelledAt;
    data['completed_at'] = completedAt;
    data['expired_at'] = expiredAt;
    data['failed_at'] = failedAt;
    data['last_error'] = lastError;
    if (stepDetails != null) {
      data['step_details'] = stepDetails!.toJson();
    }
    return data;
  }

  @override
  RunStep fromJson(data) {
    return RunStep.fromJson(data);
  }
}
