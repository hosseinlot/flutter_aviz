abstract class SearchEvent {}

class SearchGetDataEvent extends SearchEvent {
  String enteredText;
  SearchGetDataEvent(this.enteredText);
}
