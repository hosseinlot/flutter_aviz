abstract class UserEvent {}

class UserGetInfoEvent extends UserEvent {}

class UserGetAvizListEvent extends UserEvent {}

class BookmarkToggleEvent extends UserEvent {
  final String avizId;
  BookmarkToggleEvent(this.avizId);
}

class UserGetBookmarkListEvent extends UserEvent {}
