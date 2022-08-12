mixin ModelWithInitials {
  String get fullName;

  String get initials {
    final pattern = RegExp(r"[^a-zA-Zа-яА-Я\s]+");
    final byWords = fullName
        .replaceAll(pattern, '')
        .split(' ')
        .where((word) => word.isNotEmpty);

    if (byWords.length > 1) {
      return '${byWords.first[0]}${byWords.last[0]}'.toUpperCase();
    }

    return '${byWords.first[0]}${byWords.first[1]}'.toUpperCase();
  }
}
