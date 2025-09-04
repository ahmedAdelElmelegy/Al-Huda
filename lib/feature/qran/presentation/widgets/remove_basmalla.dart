extension BasmalaExtension on String {
  static const String _basmala = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';

  String removeBasmala() {
    if (trim().startsWith(_basmala)) {
      return replaceFirst(_basmala, '').trim();
    }
    return this;
  }
}
