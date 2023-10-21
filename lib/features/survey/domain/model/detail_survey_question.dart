class DetailSurvey {
  String? id;
  String? surveyName;
  int? status;
  int? totalRespondent;
  String? createdAt;
  String? updatedAt;
  List<Questions>? questions;

  DetailSurvey(
      {this.id,
      this.surveyName,
      this.status,
      this.totalRespondent,
      this.createdAt,
      this.updatedAt,
      this.questions});

  DetailSurvey.fromJson(Map<String, dynamic> json) {
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
  String? id;
  int? questionNumber;
  String? surveyId;
  String? section;
  String? inputType;
  String? questionName;
  String? questionSubject;
  List<Options>? options;

  Questions(
      {this.id,
      this.questionNumber,
      this.surveyId,
      this.section,
      this.inputType,
      this.questionName,
      this.questionSubject,
      this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionNumber = json['question_number'];
    surveyId = json['survey_id'];
    section = json['section'];
    inputType = json['input_type'];
    questionName = json['question_name'];
    questionSubject = json['question_subject'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
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

class Options {
  String? id;
  String? questionId;
  String? optionName;
  int? value;
  String? color;

  Options({this.id, this.questionId, this.optionName, this.value, this.color});

  Options.fromJson(Map<String, dynamic> json) {
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
