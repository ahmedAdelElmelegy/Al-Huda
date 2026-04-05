class QuizQuestionModel {
  final int id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String category;

  QuizQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.category,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id'] as int,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctIndex: json['correctIndex'] as int,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
      'category': category,
    };
  }
}
