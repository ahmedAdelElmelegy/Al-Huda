class AllahName {
  final String id;
  final String name;
  final String text;
  final bool inApp;
  final List<String>? highlight;
  final List<String>? noHighlight;
  final List<String> occurances;

  AllahName({
    required this.id,
    required this.name,
    required this.text,
    required this.inApp,
    this.highlight,
    this.noHighlight,
    required this.occurances,
  });

  factory AllahName.fromJson(Map<String, dynamic> json) {
    return AllahName(
      id: json['id'],
      name: json['name'],
      text: json['text'],
      inApp: json['inApp'],
      highlight: json['highlight'] != null
          ? List<String>.from(json['highlight'])
          : null,
      noHighlight: json['noHighlight'] != null
          ? List<String>.from(json['noHighlight'])
          : null,
      occurances: List<String>.from(json['occurances']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'text': text,
      'inApp': inApp,
      'highlight': highlight,
      'noHighlight': noHighlight,
      'occurances': occurances,
    };
  }

  @override
  String toString() {
    return 'AllahName{id: $id, name: $name, inApp: $inApp}';
  }
}
