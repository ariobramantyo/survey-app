class ListAllSurveyResponse {
  int? code;
  bool? status;
  String? message;
  int? totalAllData;
  List<Data>? data;

  ListAllSurveyResponse(
      {this.code, this.status, this.message, this.totalAllData, this.data});

  ListAllSurveyResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    totalAllData = json['total_all_data'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    data['total_all_data'] = totalAllData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? surveyName;
  int? status;
  int? totalRespondent;
  String? createdAt;
  String? updatedAt;
  List<Questions>? questions;

  Data(
      {this.id,
      this.surveyName,
      this.status,
      this.totalRespondent,
      this.createdAt,
      this.updatedAt,
      this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surveyName = json['survey_name'];
    status = json['status'];
    totalRespondent = json['total_respondent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['survey_name'] = surveyName;
    data['status'] = status;
    data['total_respondent'] = totalRespondent;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? questionName;
  String? inputType;
  String? questionId;

  Questions({this.questionName, this.inputType, this.questionId});

  Questions.fromJson(Map<String, dynamic> json) {
    questionName = json['question_name'];
    inputType = json['input_type'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_name'] = questionName;
    data['input_type'] = inputType;
    data['question_id'] = questionId;
    return data;
  }
}
