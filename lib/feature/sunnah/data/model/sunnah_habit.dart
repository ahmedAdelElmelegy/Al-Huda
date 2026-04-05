class SunnahHabit {
  final String id;
  final String titleAr;
  final String titleEn;
  final String category;
  final bool isCompleted;
  final int streak;
  final String? lastCompletedDate;

  SunnahHabit({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.category,
    this.isCompleted = false,
    this.streak = 0,
    this.lastCompletedDate,
  });

  factory SunnahHabit.fromJson(Map<String, dynamic> json) {
    return SunnahHabit(
      id: json['id'],
      titleAr: json['title_ar'],
      titleEn: json['title_en'],
      category: json['category'],
      isCompleted: json['isCompleted'] ?? false,
      streak: json['streak'] ?? 0,
      lastCompletedDate: json['lastCompletedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ar': titleAr,
      'title_en': titleEn,
      'category': category,
      'isCompleted': isCompleted,
      'streak': streak,
      'lastCompletedDate': lastCompletedDate,
    };
  }

  SunnahHabit copyWith({
    bool? isCompleted,
    int? streak,
    String? lastCompletedDate,
  }) {
    return SunnahHabit(
      id: id,
      titleAr: titleAr,
      titleEn: titleEn,
      category: category,
      isCompleted: isCompleted ?? this.isCompleted,
      streak: streak ?? this.streak,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
    );
  }
}
