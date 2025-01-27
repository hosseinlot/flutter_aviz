abstract class NavigationState {}

class NaviationInitState extends NavigationState {}

class NavigationbarVisibilityState extends NavigationState {
  bool visibility;
  NavigationbarVisibilityState(this.visibility);
}

class NavigationIndicatorUpdateState extends NavigationState {
  double pageNumber;
  NavigationIndicatorUpdateState(this.pageNumber);
}

class NavigationInCategoryState extends NavigationState {}

class NavigationInSubCategoryState extends NavigationState {}

class NavigationInPropertyCategoryState extends NavigationState {}

class NavigationInLocationSelectState extends NavigationState {}

class NavigationInFinilizeAdState extends NavigationState {}
