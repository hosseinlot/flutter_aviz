class Aviz {
  String id;
  String title;
  String category;
  String subCategory;
  String? createTime;
  String? thumbnail;

  Aviz(this.id, this.title, this.category, this.subCategory, this.createTime, this.thumbnail);

  factory Aviz.fromMapJson(Map<String, dynamic> jsonObject) {
    String? potentialThumbnail = jsonObject['thumbnail'];
    if (potentialThumbnail != '') {
      return Aviz(
        jsonObject['id'],
        jsonObject['title'],
        jsonObject['category'],
        jsonObject['subCategory'],
        jsonObject['created'],
        'https://aviz-app.pockethost.io/api/files/aviz/${jsonObject['id']}/${jsonObject['thumbnail']}?thumb=200x200',
      );
    } else {
      return Aviz(
        jsonObject['id'],
        jsonObject['title'],
        jsonObject['category'],
        jsonObject['subCategory'],
        jsonObject['created'],
        null,
      );
    }
  }
}
