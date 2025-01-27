import 'package:hive/hive.dart';
part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark {
  @HiveField(0)
  String aviz_id;

  Bookmark(this.aviz_id);
}
