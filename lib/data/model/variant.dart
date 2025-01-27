class Variant {
  String? title;
  dynamic value;
  String? type;
  String? avizId;

  Variant(
    this.title,
    this.value,
    this.type,
    this.avizId,
  );

  factory Variant.fromMapJson(Map<String, dynamic> jsonObject) {
    return Variant(
      jsonObject['title'],
      jsonObject['value'],
      jsonObject['type'],
      jsonObject['aviz_id'],
    );
  }
}
