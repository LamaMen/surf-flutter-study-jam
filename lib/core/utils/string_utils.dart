extension StringNullableUtils on String? {
  String withDefault(String defaultValue) {
    if (this == null || this!.isEmpty) return defaultValue;
    return this!;
  }
}
