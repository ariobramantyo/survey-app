class DetailSurveyResponse {
  int? code;
  bool? status;
  String? message;
  DataQuestionResponse? data;

  DetailSurveyResponse({this.code, this.status, this.message, this.data});

  DetailSurveyResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? DataQuestionResponse.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataQuestionResponse {
  String? id;
  String? surveyName;
  int? status;
  int? totalRespondent;
  String? createdAt;
  String? updatedAt;
  List<QuestionResponse>? questions;

  DataQuestionResponse(
      {this.id,
      this.surveyName,
      this.status,
      this.totalRespondent,
      this.createdAt,
      this.updatedAt,
      this.questions});

  DataQuestionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surveyName = json['survey_name'];
    status = json['status'];
    totalRespondent = json['total_respondent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['questions'] != null) {
      questions = <QuestionResponse>[];
      json['questions'].forEach((v) {
        questions!.add(QuestionResponse.fromJson(v));
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

class QuestionResponse {
  String? id;
  int? questionNumber;
  String? surveyId;
  String? section;
  String? inputType;
  String? questionName;
  String? questionSubject;
  List<OptionResponse>? options;

  QuestionResponse(
      {this.id,
      this.questionNumber,
      this.surveyId,
      this.section,
      this.inputType,
      this.questionName,
      this.questionSubject,
      this.options});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionNumber = json['question_number'];
    surveyId = json['survey_id'];
    section = json['section'];
    inputType = json['input_type'];
    questionName = json['question_name'];
    questionSubject = json['question_subject'];
    if (json['options'] != null) {
      options = <OptionResponse>[];
      json['options'].forEach((v) {
        options!.add(OptionResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_number'] = questionNumber;
    data['survey_id'] = surveyId;
    data['section'] = section;
    data['input_type'] = inputType;
    data['question_name'] = questionName;
    data['question_subject'] = questionSubject;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionResponse {
  String? id;
  String? questionId;
  String? optionName;
  int? value;
  String? color;

  OptionResponse(
      {this.id, this.questionId, this.optionName, this.value, this.color});

  OptionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    optionName = json['option_name'];
    value = json['value'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['option_name'] = optionName;
    data['value'] = value;
    data['color'] = color;
    return data;
  }
}
