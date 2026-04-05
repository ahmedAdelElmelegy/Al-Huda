import 'dart:convert';
import 'package:al_huda/feature/quiz/data/model/quiz_question_model.dart';
import 'package:flutter/services.dart';

class QuizRepo {
  Future<List<QuizQuestionModel>> getQuestions() async {
    try {
      final String response = await rootBundle.loadString('assets/data/quiz_questions.json');
      final data = await json.decode(response);
      final List questionsList = data['questions'];
      return questionsList.map((json) => QuizQuestionModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<QuizQuestionModel>> getRandomQuestions(int count) async {
    final questions = await getQuestions();
    if (questions.isEmpty) return [];
    questions.shuffle();
    return questions.take(count).toList();
  }
}
