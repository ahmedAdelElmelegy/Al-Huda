import 'package:al_huda/feature/quiz/data/repo/quiz_repo.dart';
import 'package:al_huda/feature/quiz/presentation/manager/quiz_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepo _quizRepo;

  QuizCubit(this._quizRepo) : super(QuizInitial());

  Future<void> loadQuiz() async {
    emit(QuizLoading());
    try {
      final questions = await _quizRepo.getRandomQuestions(10);
      if (questions.isEmpty) {
        emit(const QuizError("لا توجد أسئلة متاحة حالياً"));
      } else {
        emit(QuizLoaded(
          questions: questions,
          currentIndex: 0,
          score: 0,
        ));
      }
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  void selectAnswer(int index) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.answered) return;

      int newScore = currentState.score;
      if (index == currentState.questions[currentState.currentIndex].correctIndex) {
        newScore++;
      }

      emit(currentState.copyWith(
        selectedAnswer: index,
        answered: true,
        score: newScore,
      ));
    }
  }

  void nextQuestion() {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.currentIndex < currentState.questions.length - 1) {
        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          selectedAnswer: null,
          answered: false,
        ));
      } else {
        emit(QuizCompleted(
          score: currentState.score,
          total: currentState.questions.length,
        ));
      }
    }
  }

  void restartQuiz() {
    loadQuiz();
  }
}
