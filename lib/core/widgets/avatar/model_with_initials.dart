mixin ModelWithAvatar {
  String get name;

  String get initials {
    final pattern = RegExp(r"[^a-zA-Zа-яА-Я0-9\s]+");
    final byWords = name
        .replaceAll(pattern, '')
        .split(' ')
        .where((word) => word.isNotEmpty);

    if (byWords.length > 1) {
      return '${byWords.first[0]}${byWords.last[0]}'.toUpperCase();
    }

    if (byWords.first.length > 1) {
      return '${byWords.first[0]}${byWords.first[1]}'.toUpperCase();
    }

    return byWords.first[0].toUpperCase();
  }

  String? get avatar;
}
