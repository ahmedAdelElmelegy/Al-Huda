import 'package:al_huda/feature/quiz/data/model/quiz_question_model.dart';
import 'package:equatable/equatable.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizQuestionModel> questions;
  final int currentIndex;
  final int score;
  final int? selectedAnswer;
  final bool answered;

  const QuizLoaded({
    required this.questions,
    required this.currentIndex,
    required this.score,
    this.selectedAnswer,
    this.answered = false,
  });

  @override
  List<Object?> get props => [questions, currentIndex, score, selectedAnswer, answered];

  QuizLoaded copyWith({
    List<QuizQuestionModel>? questions,
    int? currentIndex,
    int? score,
    int? selectedAnswer,
    bool? answered,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer, // Can be null
      answered: answered ?? this.answered,
    );
  }
}

class QuizCompleted extends QuizState {
  final int score;
  final int total;

  const QuizCompleted({required this.score, required this.total});

  @override
  List<Object?> get props => [score, total];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
