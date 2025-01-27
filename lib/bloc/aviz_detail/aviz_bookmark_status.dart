import 'package:flutter/material.dart';

@immutable
abstract class AvizBookmarkStatus {}

class AvizBookmarkInitial extends AvizBookmarkStatus {}

class AvizBookmarkSuccess extends AvizBookmarkStatus {
  final bool isBookmarked;
  AvizBookmarkSuccess(this.isBookmarked);
}

class AvizBookmarkFailed extends AvizBookmarkStatus {
  final String message;
  AvizBookmarkFailed(this.message);
}
