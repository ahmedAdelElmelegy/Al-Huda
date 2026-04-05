import 'package:equatable/equatable.dart';

class SunnahHabit extends Equatable {
  final String id;
  final String title;
  final String category;
  final bool isCompletedToday;
  final int streak;

  const SunnahHabit({
    required this.id,
    required this.title,
    required this.category,
    this.isCompletedToday = false,
    this.streak = 0,
  });

  SunnahHabit copyWith({
    String? title,
    String? category,
    bool? isCompletedToday,
    int? streak,
  }) {
    return SunnahHabit(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      streak: streak ?? this.streak,
    );
  }

  factory SunnahHabit.fromJson(Map<String, dynamic> json) {
    return SunnahHabit(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      isCompletedToday: json['isCompletedToday'] ?? false,
      streak: json['streak'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'isCompletedToday': isCompletedToday,
      'streak': streak,
    };
  }

  @override
  List<Object?> get props => [id, title, category, isCompletedToday, streak];
}
